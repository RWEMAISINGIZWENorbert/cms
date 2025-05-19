import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_associate/data/models/category.dart';

// Events
abstract class CategoryEvent {}

class LoadCategories extends CategoryEvent {}

// States
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;

  CategoryLoaded(this.categories);
}

class CategoryError extends CategoryState {
  final String message;

  CategoryError(this.message);
}

// Bloc
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<LoadCategories>((event, emit) async {
      try {
        emit(CategoryLoading());
        final categories = Category.getDefaultCategories();
        emit(CategoryLoaded(categories));
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });
  }
} 