import 'dart:async';
import 'dart:developer';
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
    on<SaveSectionEvent>((event, emit) {
      emit(state.copyWith(section: event.section));
      add(LoadProducts(event.section.branch));
    });

    on<SelectSize>((event, emit) {
      emit(state.copyWith(
        selectedSize: event.size,
        selectedColor: '', // O'lcham o'zgarsa rang reset bo'ladi
      ));
    });

    on<SelectColor>((event, emit) {
      emit(state.copyWith(selectedColor: event.color));
    });
  }

  FutureOr<void> _getSingleProducts(LoadProductById event, Emitter<ThisBlocState> emit) async {
    log("message 1");
    emit(state.copyWith(singleProductStatus: FormzSubmissionStatus.inProgress));
    final res = await repository.getSingleProduct(id: "${event.id}");
    log("message 2");
    if (res != null) {
      log("message 3");
      emit(state.copyWith(
        singleProduct: res,
        singleProductStatus: FormzSubmissionStatus.success,
      ));
      for (var o in res.variants) {
        print(" price ${o.price}");
      }
      log("message 4  ${res.variants.length}");
    } else {
      log("message 5");
      emit(state.copyWith(singleProductStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _getProducts(LoadProducts event, Emitter<ThisBlocState> emit) async {
    emit(state.copyWith(productStatus: FormzSubmissionStatus.inProgress));
    final res = await repository.getProduct(branch: event.branch);
    if (res.isNotEmpty) {
      emit(state.copyWith(productStatus: FormzSubmissionStatus.success, products: res));
    } else {
      emit(state.copyWith(
        productStatus: FormzSubmissionStatus.failure,
        errorMSg: "Something went wrong\n please refresh this page",
      ));
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
