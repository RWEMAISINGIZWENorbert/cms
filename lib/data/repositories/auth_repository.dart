// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tech_associate/data/models/user.dart';
import 'package:tech_associate/data/repositories/user_repository.dart';
import 'package:tech_associate/utils/auth_manager.dart';

class AuthRepository {
  final String baseUrl;
  final UserRepository userRepository;

  AuthRepository({
    required this.baseUrl,
    required this.userRepository,
  });

  Future<String> signUp({
    required String email,
    required String userName,
    required String department,
    required int telephone,
    required String password,
    required String cPassword,
  }) async {
    print("----------------Startert----------------------");
        
    final url = Uri.parse("$baseUrl/signUp");
    final data = jsonEncode({
      'name': userName,
      'email': email,
      'password': password,        
      'department': department,
      'telephone': telephone,      
    });

    print("Data $data");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'name': userName,
          'email': email,
          'password': password,        
          'department': department,
          'telephone': telephone,
        }),
      );
      print("--------------Continue----------------------------");
      if (response.statusCode == 201) {
        return "Account created successfully";
      } else {
        throw Exception(jsonDecode(response.body)['msg'] ?? 'Sign up failed');
      }
    } catch(error) {
      print("Error Occred $error");
      throw Exception('Error $error');
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Please fill the required credentials');
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signIn'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        if (data['data'] != null && data['data']['accessToken'] != null) {
          // Save token
          await AuthManager.saveToken(data['data']['accessToken']);
          
          // Save user data
          if (data['data']['user'] != null) {
            final user = User.fromJson(data['data']['user']);
            await userRepository.saveUser(user);
          } else {
            throw Exception('User data not found in response');
          }
        } else {
          throw Exception('Invalid response format from server');
        }
      } else {
        throw Exception(data['msg'] ?? 'Login failed');
      }
    } catch (e) {
      // Clear any partial data on error
      await AuthManager.logout();
      await userRepository.clearUser();
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<void> logout() async {
     AuthManager.logout();
    await userRepository.clearUser(); // Clear user data on logout
  }

  Future<String?> getAccessToken() async {
    return await AuthManager.readAuth();
  }   
}