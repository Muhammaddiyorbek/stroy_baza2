import 'package:equatable/equatable.dart';

class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductEvent {}

class GetBannerEvent extends ProductEvent {}

class GetProductByIdEvent extends ProductEvent {
  final String productId;

  GetProductByIdEvent(this.productId);
}

class LoadProductById extends ProductEvent {
  final int id;

  LoadProductById(this.id);
}
