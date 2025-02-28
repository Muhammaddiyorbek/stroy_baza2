import 'package:equatable/equatable.dart';

import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCategories extends CategoryEvent {}

class SearchCategory extends CategoryEvent {
  final String query;

  SearchCategory(this.query);

  @override
  List<Object> get props => [query];
}

class SelectCategory extends CategoryEvent {
  final String category;

  SelectCategory(this.category);

  @override
  List<Object> get props => [category];
}
