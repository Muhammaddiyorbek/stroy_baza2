import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:stroy_baza/logic/bloc/product_event.dart';
import 'package:stroy_baza/logic/bloc/product_state.dart';
import 'package:stroy_baza/logic/repository/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ThisBlocState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(const ThisBlocState()) {
    on<GetBannerEvent>((event, emit) => _getBanner(event, emit));
    on<LoadProducts>((event, emit) => _getProducts(event, emit));
    on<LoadProductById>((event, emit) => _getSingleProducts(event, emit));
  }

  FutureOr<void> _getSingleProducts(LoadProductById event, Emitter<ThisBlocState> emit) async {
    emit(state.copyWith(singleProductStatus: FormzSubmissionStatus.inProgress));
    final res = await repository.getSingleProduct(id: "${event.id}");
    if (res != null) {
      emit(state.copyWith(singleProduct: res, singleProductStatus: FormzSubmissionStatus.success));
    } else {
      emit(state.copyWith(singleProductStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _getProducts(LoadProducts event, Emitter<ThisBlocState> emit) async {
    emit(state.copyWith(productStatus: FormzSubmissionStatus.inProgress));
    final res = await repository.getProduct();
    if (res.isNotEmpty) {
      emit(state.copyWith(productStatus: FormzSubmissionStatus.success, products: res));
    } else {
      emit(
        state.copyWith(productStatus: FormzSubmissionStatus.failure, errorMSg: "Something went wrong\n please refresh this page"),
      );
    }
  }

  FutureOr<void> _getBanner(GetBannerEvent event, Emitter<ThisBlocState> emit) async {
    emit(state.copyWith(bannerStatus: FormzSubmissionStatus.inProgress));
    final res = await repository.getBanner();
    if (res.isNotEmpty) {
      emit(state.copyWith(bannerStatus: FormzSubmissionStatus.success, banners: res));
    } else {
      emit(state.copyWith(banners: []));
    }
  }
}
