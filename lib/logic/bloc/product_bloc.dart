import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stroy_baza/logic/bloc/product_event.dart';
import 'package:stroy_baza/logic/bloc/product_state.dart';
import 'package:stroy_baza/logic/repository/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc(this._productRepository) : super(ProductInitialState()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoadingState());
      try {
        final products = await _productRepository.getProducts();
        emit(ProductLoadedState(products));
      } catch (e) {
        emit(ProductErrorState(e.toString()));
      }
    });

    on<GetProductByIdEvent>((event, emit) async {
      emit(ProductLoadingState());
      try {
        final products = await _productRepository.getProducts();
        final product = products.firstWhere((p) => p.id.toString() == event.productId);
        emit(ProductLoadedState([product]));
      } catch (e) {
        emit(ProductErrorState(e.toString()));
      }
    });
  }
}