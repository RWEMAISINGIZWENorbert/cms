import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_associate/bloc/department/department_bloc.dart';
import 'package:tech_associate/data/models/department.dart';
import 'package:tech_associate/widgets/select_method_option.dart';

class DepartmentSelector extends StatelessWidget {
  final String? selectedDepartmentId;
  final Function(Department) onDepartmentSelected;

  const DepartmentSelector({
    Key? key,
    this.selectedDepartmentId,
    required this.onDepartmentSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DepartmentBloc, DepartmentState>(
      builder: (context, state) {
        if (state is DepartmentInitial || state is DepartmentLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is DepartmentError) {
          return Center(
            child: Text(
              'Error loading departments: ${state.message}',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          );
        }

        if (state is DepartmentLoaded) {
          final departments = state.departments;
          if (departments.isEmpty) {
            return const Center(
              child: Text('No departments available'),
            );
          }

          String? initialValue;
          if (selectedDepartmentId != null) {
            try {
              initialValue = departments.firstWhere((d) => d.id == selectedDepartmentId).name;
            } catch (e) {
              // If the selected department is not found, ignore it
              initialValue = null;
            }
          }

          return SelectMethodOption(
            label: 'department',
            options: departments.map((d) => d.name).toList(),
            initialValue: initialValue,
            onSelect: (String? departmentName) {
              if (departmentName != null) {
                final department = departments.firstWhere((d) => d.name == departmentName);
                print("Depart ment ${department.name}");
                onDepartmentSelected(department);
              }
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
} 