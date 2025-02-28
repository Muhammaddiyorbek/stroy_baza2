import 'package:equatable/equatable.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<String> categories;
  final List<String> filteredCategories;
  final String selectedCategory;

  CategoryLoaded({
    required this.categories,
    required this.filteredCategories,
    required this.selectedCategory,
  });

  @override
  List<Object> get props => [categories, filteredCategories, selectedCategory];

  CategoryLoaded copyWith({
    List<String>? categories,
    List<String>? filteredCategories,
    String? selectedCategory,
  }) {
    return CategoryLoaded(
      categories: categories ?? this.categories,
      filteredCategories: filteredCategories ?? this.filteredCategories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
