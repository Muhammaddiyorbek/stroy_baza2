import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stroy_baza/logic/bloc/product_event.dart';
import 'package:stroy_baza/logic/bloc/product_state.dart';
import 'package:stroy_baza/logic/repository/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductInitialState()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoadingState());
      try {
        final products = await repository.getProducts();  // _productRepository emas, repository ishlatiladi
        emit(ProductLoadedState(products));
      } catch (e) {
        emit(ProductErrorState(e.toString()));
      }
    });

    on<LoadProductById>((event, emit) async {
      try {
        final products = (state as ProductLoadedState).products;
        final product = products.firstWhere((p) => p.id == event.id);
        emit(ProductSelectedState(product));
      } catch (e) {
        emit(ProductErrorState(e.toString()));
      }
    });
  }
}