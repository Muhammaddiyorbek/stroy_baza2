import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:stroy_baza/models/banner_model.dart';
import 'package:stroy_baza/models/product.dart';

class ThisBlocState extends Equatable {
  final List<Product> products;
  final List<BannerModel> banners;
  final String errorMSg;
  final Product singleProduct;
  final FormzSubmissionStatus bannerStatus;
  final FormzSubmissionStatus productStatus;
  final FormzSubmissionStatus singleProductStatus;

  const ThisBlocState({
    this.bannerStatus = FormzSubmissionStatus.initial,
    this.singleProductStatus = FormzSubmissionStatus.initial,
    this.productStatus = FormzSubmissionStatus.initial,
    this.errorMSg = '',
    this.products = const [],
    this.banners = const [],
    this.singleProduct = const Product(
      id: -1,
      variants: [],
      branch: -1,
      category: -1,
      descriptionEn: '',
      descriptionRu: '',
      descriptionUz: '',
      image: '',
      isAvailable: false,
      nameEn: '',
      nameRu: '',
      nameUz: '',
    ),
  });

  ThisBlocState copyWith({
    List<Product>? products,
    List<BannerModel>? banners,
    String? errorMSg,
    Product? singleProduct,
    FormzSubmissionStatus? bannerStatus,
    FormzSubmissionStatus? productStatus,
    FormzSubmissionStatus? singleProductStatus,
  }) =>
      ThisBlocState(
        banners: banners ?? this.banners,
        bannerStatus: bannerStatus ?? this.bannerStatus,
        productStatus: productStatus ?? this.productStatus,
        singleProductStatus: singleProductStatus ?? this.singleProductStatus,
        products: products ?? this.products,
        errorMSg: errorMSg ?? this.errorMSg,
        singleProduct: singleProduct ?? this.singleProduct,
      );

  @override
  List<Object?> get props => [
        banners,
        products,
        singleProductStatus,
        errorMSg,
        singleProduct,
        bannerStatus,
        productStatus,
      ];
}

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
