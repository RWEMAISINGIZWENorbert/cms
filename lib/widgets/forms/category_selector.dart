import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_associate/bloc/category/category_bloc.dart';
import 'package:tech_associate/data/models/category.dart';
import 'package:tech_associate/widgets/select_method_option.dart';

class CategorySelector extends StatelessWidget {
  final String? selectedCategoryId;
  final Function(Category) onCategorySelected;

  const CategorySelector({
    Key? key,
    this.selectedCategoryId,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryInitial || state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CategoryError) {
          return Center(
            child: Text(
              'Error loading categories: ${state.message}',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          );
        }

        if (state is CategoryLoaded) {
          final categories = state.categories;
          if (categories.isEmpty) {
            return const Center(
              child: Text('No categories available'),
            );
          }

          String? initialValue;
          if (selectedCategoryId != null) {
            try {
              initialValue = categories.firstWhere((c) => c.id == selectedCategoryId).name;
            } catch (e) {
              // If the selected category is not found, ignore it
              initialValue = null;
            }
          }

          return SelectMethodOption(
            label: 'category',
            options: categories.map((c) => c.name).toList(),
            initialValue: initialValue,
            onSelect: (String? categoryName) {
              if (categoryName != null) {
                final category = categories.firstWhere((c) => c.name == categoryName);
                onCategorySelected(category);
              }
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
} 