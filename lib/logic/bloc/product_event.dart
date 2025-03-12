abstract class ProductEvent {}

class LoadProducts extends ProductEvent {}

class GetProductByIdEvent extends ProductEvent {
  final String productId;
  GetProductByIdEvent(this.productId);
}

class LoadProductById extends ProductEvent {
  final int id;
  
  LoadProductById(this.id);
}