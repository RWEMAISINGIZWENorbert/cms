import 'dart:convert';
import 'dart:math';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:tech_associate/data/models/compliant.dart';
import 'package:uuid/uuid.dart';
import 'package:tech_associate/utils/auth_manager.dart';

class CompliantRepository {
  final Box<Compliant> compliantBox;
  final String baseUrl = 'https://cms-qctx.onrender.com/complaints';

  CompliantRepository({required this.compliantBox});

  Future<List<Compliant>> getAllCompliants() async {
    try {
      // First get local data
      final localCompliants = compliantBox.values.toList();
      
      // Try to get server data
      final token = await AuthManager.readAuth();
      if (token != null) {
        try {
          final response = await http.get(
            Uri.parse('$baseUrl/department'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          );

          if (response.statusCode == 200) {
            final List<dynamic> data = jsonDecode(response.body)['data'];
            final serverCompliants = data.map((json) => Compliant.fromJson(json)).toList();
            
            // Merge server data with local data
            for (var serverCompliant in serverCompliants) {
              // Find matching local complaint by server ID or other unique identifiers
              final localCompliant = localCompliants.firstWhere(
                (c) => c.serverId == serverCompliant.serverId || 
                       (c.title == serverCompliant.title && 
                        c.submittedBy == serverCompliant.submittedBy &&
                        c.createdAt.difference(serverCompliant.createdAt).inMinutes.abs() < 5),
                orElse: () {
                  // If no match found, create new local complaint with local ID
                  final newLocalId = _generateUnique6DigitId().toString();
                  return serverCompliant.copyWith(
                    id: newLocalId,
                    serverId: serverCompliant.id, // Store server ID for future reference
                  );
                },
              );
              
              // Update local storage if server data is newer
              if (serverCompliant.updatedAt.isAfter(localCompliant.updatedAt)) {
                final updatedCompliant = serverCompliant.copyWith(
                  id: localCompliant.id, // Keep local ID
                  serverId: serverCompliant.id, // Update server ID reference
                );
                await compliantBox.put(updatedCompliant.id, updatedCompliant);
              }
            }
            
            // Return merged data
            return compliantBox.values.toList();
          }
        } catch (e) {
          print('Error fetching server data: $e');
          // If server fetch fails, return local data
          return localCompliants;
        }
      }
      
      // If no token or server fetch failed, return local data
      return localCompliants;
    } catch (e) {
      print('Error in getAllCompliants: $e');
      return [];
    }
  }

  Future<String> _generateUnique6DigitId() async {
    final random = Random();
    String id;
    do {
      id = (100000 + random.nextInt(900000)).toString();
    } while (compliantBox.values.any((item) => item.id == id));
    return id;
  }

  Future<Compliant> addCompliant({
    required String title,
    required String description,
    required String category,
    required String location,
    required String submittedBy,
    required String status,
    required String telephoneNumber,
  }) async {
    try {
      // Generate local ID first
      final localId = await _generateUnique6DigitId();
      
      print('Sending request to: ${baseUrl}/create');
      print('Request body: ${jsonEncode({
        'title': title,
        'description': description,
        'category': category,
        'location': location,
        'submittedBy': submittedBy,
        'status': status,
        'telephoneNumber': telephoneNumber,
      })}');
      
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'title': title,
          'description': description,
          'category': category,
          'location': location,
          'submittedBy': submittedBy,
          'status': status,
          'telephoneNumber': telephoneNumber,
        }),
      );
// 951634
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        if (responseData['data'] == null) {
          throw Exception('Server response missing data field');
        }
        
        final data = responseData['data'];
        final serverCompliant = Compliant.fromJson(data);
        
        // Create new complaint with local ID but keep server ID reference
        final newCompliant = serverCompliant.copyWith(
          id: localId,
          serverId: serverCompliant.id,
        );
        
        // Save to local storage
        await compliantBox.put(newCompliant.id, newCompliant);
        
        return newCompliant;
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['msg'] ?? 'Failed to create complaint');
      }
    } catch (e) {
      print('Error creating complaint: $e');
      throw Exception('Error creating complaint: $e');
    }
  }

  Future<Compliant> updateCompliant(Compliant compliant) async {
    try {
      final token = await AuthManager.readAuth();
      if (token == null) {
        throw Exception('Not authenticated');
      }

      // Use serverId for the update if available
      final serverId = compliant.serverId ?? compliant.id;
      
      final response = await http.put(
        Uri.parse('$baseUrl/$serverId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(compliant.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        final serverCompliant = Compliant.fromJson(data);
        
        // Keep local ID but update with server data
        final updatedCompliant = serverCompliant.copyWith(
          id: compliant.id,
          serverId: serverCompliant.id,
        );
        
        // Update local storage
        await compliantBox.put(updatedCompliant.id, updatedCompliant);
        
        return updatedCompliant;
      } else {
        throw Exception(jsonDecode(response.body)['msg'] ?? 'Failed to update complaint');
      }
    } catch (e) {
      throw Exception('Error updating complaint: $e');
    }
  }

  Future<void> deleteCompliant(String id) async {
    try {
      final token = await AuthManager.readAuth();
      if (token == null) {
        throw Exception('Not authenticated');
      }

      // Get the complaint to find its server ID
      final compliant = await getCompliantById(id);
      if (compliant == null) {
        throw Exception('Complaint not found');
      }

      // Use serverId for deletion if available
      final serverId = compliant.serverId ?? id;
      
      final response = await http.delete(
        Uri.parse('$baseUrl/delete/$serverId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        // Remove from local storage
        await compliantBox.delete(id);
      } else {
        throw Exception(jsonDecode(response.body)['msg'] ?? 'Failed to delete complaint');
      }
    } catch (e) {
      throw Exception('Error deleting complaint: $e');
    }
  }

  Future<Compliant?> getCompliantById(String id) async {
    try {
      // First check local storage
      final localCompliant = compliantBox.get(id);
      
      // Try to get from server
      final token = await AuthManager.readAuth();
      if (token != null) {
        try {
          final response = await http.get(
            Uri.parse('$baseUrl/$id'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          );

          if (response.statusCode == 200) {
            final data = jsonDecode(response.body)['data'];
            final serverCompliant = Compliant.fromJson(data);
            
            // Update local storage if server data is newer
            if (localCompliant == null || 
                serverCompliant.updatedAt.isAfter(localCompliant.updatedAt)) {
              await compliantBox.put(serverCompliant.id, serverCompliant);
              return serverCompliant;
            }
          }
        } catch (e) {
          print('Error fetching server data: $e');
        }
      }
      
      // Return local data if server fetch failed or no token
      return localCompliant;
    } catch (e) {
      print('Error in getCompliantById: $e');
      return null;
    }
  }

  Future<List<Compliant>> getCompliantsByStatus(CompliantStatus status) async {
    return compliantBox.values
        .where((compliant) => compliant.status == status)
        .toList();
  }

  Future<List<Compliant>> getCompliantsByPriority(CompliantPriority priority) async {
    return compliantBox.values
        .where((compliant) => compliant.priority == priority)
        .toList();
  }

  Future<List<Compliant>> getCompliantsByCategory(String category) async {
    return compliantBox.values
        .where((compliant) => compliant.categoryId == category)
        .toList();
  }

  Future<List<Compliant>> getCompliantsByAssignedTo(String assignedTo) async {
    return compliantBox.values
        .where((compliant) => compliant.assignedTo == assignedTo)
        .toList();
  }

  Future<List<Compliant>> getCompliantsBySubmittedBy(String submittedBy) async {
    return compliantBox.values
        .where((compliant) => compliant.submittedBy == submittedBy)
        .toList();
  }

  Future<List<Compliant>> searchCompliants(String query) async {
    final lowercaseQuery = query.toLowerCase();
    return compliantBox.values.where((compliant) {
      return compliant.title.toLowerCase().contains(lowercaseQuery) ||
          compliant.description.toLowerCase().contains(lowercaseQuery) ||
          compliant.categoryId.toLowerCase().contains(lowercaseQuery) ||
          compliant.location.toLowerCase().contains(lowercaseQuery) ||
          compliant.telephoneNumber.contains(lowercaseQuery);
    }).toList();
  }
} 