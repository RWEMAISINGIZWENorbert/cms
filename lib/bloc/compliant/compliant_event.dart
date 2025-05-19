import 'package:equatable/equatable.dart';
import 'package:tech_associate/data/models/compliant.dart';

abstract class CompliantEvent extends Equatable {
  const CompliantEvent();

  @override
  List<Object?> get props => [];
}

class AddCompliant extends CompliantEvent {
  final String title;
  final String description;
  final String category;
  final String location;
  final String submittedBy;
  final String telephoneNumber;
  final List<String> attachments;

  const AddCompliant({
    required this.title,
    required this.description,
    required this.category,
    required this.location,
    required this.submittedBy,
    required this.telephoneNumber,
    this.attachments = const [],
  });

  @override
  List<Object?> get props => [
        title,
        description,
        category,
        location,
        submittedBy,
        telephoneNumber,
        attachments,
      ];
}

class LoadCompliants extends CompliantEvent {}

class UpdateCompliant extends CompliantEvent {
  final Compliant compliant;

  const UpdateCompliant(this.compliant);

  @override
  List<Object?> get props => [compliant];
}

class DeleteCompliant extends CompliantEvent {
  final String id;

  const DeleteCompliant(this.id);

  @override
  List<Object?> get props => [id];
}

class TrackCompliant extends CompliantEvent {
  final String ticketId;

  const TrackCompliant({required this.ticketId});

  @override
  List<Object?> get props => [ticketId];
}