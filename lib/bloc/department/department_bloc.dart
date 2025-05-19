import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_associate/data/models/department.dart';


abstract class DepartmentEvent {}

class LoadDepartments extends DepartmentEvent {}

abstract class DepartmentState {}

class DepartmentInitial extends DepartmentState {}

class DepartmentLoading extends DepartmentState {}

class DepartmentLoaded extends DepartmentState {
  final List<Department> departments;

  DepartmentLoaded(this.departments);
}

class DepartmentError extends DepartmentState {
  final String message;

  DepartmentError(this.message);
}

class DepartmentBloc extends Bloc<DepartmentEvent, DepartmentState> {
  DepartmentBloc() : super(DepartmentInitial()) {
    on<LoadDepartments>((event, emit) async {
      try {
        emit(DepartmentLoading());
        // For MVP, we'll use the default departments
        final departments = Department.getDefaultDepartments();
        emit(DepartmentLoaded(departments));
      } catch (e) {
        emit(DepartmentError(e.toString()));
      }
    });
  }
} 