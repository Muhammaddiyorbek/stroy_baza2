import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stroy_baza/presentation/blocs/search/search_event.dart';
import 'package:stroy_baza/presentation/blocs/search/search_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final List<String> _categories = [
    "Penoplesk",
    "Teplesk",
    "Kley",
    "Oboy va kraskalar",
    "Bazalt",
    "Steklovata",
    "Knauf",
    "Folgaizolyatsiya"
  ];

  CategoryBloc() : super(CategoryInitial()) {
    on<LoadCategories>((event, emit) {
      emit(CategoryLoaded(
        categories: _categories,
        filteredCategories: _categories,
        selectedCategory: "",
      ));
    });

    on<SelectCategory>((event, emit) {
      if (state is CategoryLoaded) {
        final currentState = state as CategoryLoaded;
        emit(currentState.copyWith(selectedCategory: event.category));
      }
    });

    on<SearchCategory>((event, emit) {
      if (state is CategoryLoaded) {
        final currentState = state as CategoryLoaded;
        final filtered =
        currentState.categories.where((category) => category.toLowerCase().contains(event.query.toLowerCase())).toList();
        emit(currentState.copyWith(filteredCategories: filtered));
      }
    });
  }
}
