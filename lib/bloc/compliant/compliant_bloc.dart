import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_associate/config/sms_config.dart';
import 'package:tech_associate/data/models/compliant.dart';
import 'package:tech_associate/data/repositories/compliant_repository.dart';
import 'package:tech_associate/data/repositories/user_repository.dart';
import 'package:tech_associate/bloc/compliant/compliant_event.dart';
import 'package:tech_associate/bloc/compliant/compliant_state.dart';
import 'package:tech_associate/services/sms_service.dart';
import 'package:tech_associate/utils/connectivity_utils.dart';

class CompliantBloc extends Bloc<CompliantEvent, CompliantState> {
  final CompliantRepository repository;
  final UserRepository userRepository;
  final SMSService _smsService = SMSService(
    accountSid: SMSConfig.accountSid,
    authToken: SMSConfig.authToken,
    senderId: SMSConfig.senderId,
  );

  CompliantBloc({
    required this.repository,
    required this.userRepository,
  }) : super(CompliantInitial()) {
    on<LoadCompliants>(_onLoadCompliants);
    on<AddCompliant>(_onAddCompliant);
    on<UpdateCompliant>(_onUpdateCompliant);
    on<DeleteCompliant>(_onDeleteCompliant);
    on<TrackCompliant>(_onTrackCompliant);    
  }

  Future<void> _onLoadCompliants(
    LoadCompliants event,
    Emitter<CompliantState> emit,
  ) async {
    emit(CompliantLoading());
    try {
      // Get current user
      final currentUser = await userRepository.getCurrentUser();
      
      if (currentUser == null) {
        emit(const CompliantError('User not logged in'));
        return;
      }

      // Check internet connection
      bool isConnected = await hasInternetConnection();
      
      // Get compliants (repository will handle local/server sync)
      final allCompliants = await repository.getAllCompliants();
      
      // Filter compliants based on user's department
      final filteredCompliants = allCompliants.where((compliant) {
        // If user is admin (you can add this check based on your user model)
        if (currentUser.department.toLowerCase() == 'admin') {
          return true; // Show all compliants for admin
        }
        print("---------------------------------------The Category ${compliant.categoryId}----------------------------");
        // For other users, show only compliants matching their department
        return compliant.categoryId.toLowerCase() == currentUser.department.toLowerCase();
      }).toList();

      if (filteredCompliants.isEmpty) {
        if (isConnected) {
          emit(const CompliantError('No complaints found'));
        } else {
          emit(const CompliantError('No complaints found in offline mode'));
        }
      } else {
        emit(CompliantLoaded(filteredCompliants));
      }
    } catch (e) {
      emit(CompliantError('Failed to load compliants: ${e.toString()}'));
    }
  }

  Future<void> _onAddCompliant(
    AddCompliant event,
    Emitter<CompliantState> emit,
  ) async {
    emit(CompliantLoading());
    try {
      final newCompliant = await repository.addCompliant(
        title: event.title,
        description: event.description,
        category: event.category,
        location: event.location,
        submittedBy: event.submittedBy,
        status: 'open',
        telephoneNumber: event.telephoneNumber
      );
      
      final compliants = await repository.getAllCompliants();
      emit(CompliantLoaded(compliants));
      emit(CompliantSuccess('Compliant added successfully with ticket ${newCompliant.id}'));
    } catch (e) {
      emit(CompliantError('Failed to add compliant: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateCompliant(
    UpdateCompliant event,
    Emitter<CompliantState> emit,
  ) async {
    emit(CompliantLoading());
    try {
      // Get the old complaint to check if status changed
      final oldCompliant = await repository.getCompliantById(event.compliant.id);
      
      final updatedCompliant = await repository.updateCompliant(event.compliant);
       
      // If status changed, send SMS notification
      if (oldCompliant != null && oldCompliant.status != updatedCompliant.status) {
        await _smsService.sendStatusUpdate(
          toNumber: "+25${updatedCompliant.telephoneNumber}",
          complaintId: updatedCompliant.id,
          status: updatedCompliant.status.displayName,
          title: updatedCompliant.title,
          date: updatedCompliant.updatedAt
        );
        print('---------------------------------Done----------------------------');
      }
      
      final compliants = await repository.getAllCompliants();
      emit(CompliantLoaded(compliants));
      emit(CompliantSuccess(
        'Compliant updated successfully',
        updatedCompliant: updatedCompliant,
      ));
    } catch (e) {
      emit(CompliantError('Failed to update compliant: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteCompliant(
    DeleteCompliant event,
    Emitter<CompliantState> emit,
  ) async {
    emit(CompliantLoading());
    try {
      await repository.deleteCompliant(event.id);
      
      final compliants = await repository.getAllCompliants();
      emit(CompliantLoaded(compliants));
      emit(const CompliantSuccess('Compliant deleted successfully'));
    } catch (e) {
      emit(CompliantError('Failed to delete compliant: ${e.toString()}'));
    }
  }
 
Future<void> _onTrackCompliant(
  TrackCompliant event,
  Emitter<CompliantState> emit,
) async {
  emit(CompliantLoading());
  try {
    final compliant = await repository.getCompliantById(event.ticketId);
    if (compliant != null) {
      emit(CompliantTracked(compliant: compliant));
    } else {
      emit(const CompliantTracked(error: "No complaint found for this ticket ID."));
    }
  } catch (e) {
    emit(CompliantError('Failed to track compliant: ${e.toString()}'));
  }
} 
} 