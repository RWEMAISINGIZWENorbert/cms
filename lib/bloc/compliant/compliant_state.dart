import 'package:equatable/equatable.dart';
import 'package:tech_associate/data/models/compliant.dart';

abstract class CompliantState extends Equatable {
  const CompliantState();

  @override
  List<Object?> get props => [];
}

class CompliantInitial extends CompliantState {}

class CompliantLoading extends CompliantState {}

class CompliantLoaded extends CompliantState {
  final List<Compliant> compliants;

  const CompliantLoaded(this.compliants);

  @override
  List<Object?> get props => [compliants];
}

class CompliantError extends CompliantState {
  final String message;

  const CompliantError(this.message);

  @override
  List<Object?> get props => [message];
}

class CompliantSuccess extends CompliantState {
  final String message;
  final Compliant? updatedCompliant;

  const CompliantSuccess(this.message, {this.updatedCompliant});

  @override
  List<Object?> get props => [message, updatedCompliant];
} 

class CompliantTracked extends CompliantState {
  final Compliant? compliant;
  final String? error;

  const CompliantTracked({this.compliant, this.error});

  @override
  List<Object?> get props => [compliant, error];
}