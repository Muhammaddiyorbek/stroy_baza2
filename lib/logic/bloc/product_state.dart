import 'package:stroy_baza/models/product.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List<Product> products;
  ProductLoadedState(this.products);
}

// Yangi state qo'shildi
class SingleProductLoadedState extends ProductState {
  final Product product;
  SingleProductLoadedState(this.product);
}

class ProductErrorState extends ProductState {
  final String message;
  ProductErrorState(this.message);
}

class ProductSelectedState extends ProductState {
  final Product product;

  ProductSelectedState(this.product);
}