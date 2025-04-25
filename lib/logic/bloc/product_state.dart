import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:stroy_baza/core/utils/enums.dart';
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
  final SectionEnum section;

  final String selectedSize;
  final String selectedColor;

  const ThisBlocState({
    this.section = SectionEnum.base,
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
    this.selectedColor = '',
    this.selectedSize = '',
  });

  ThisBlocState copyWith({
    SectionEnum? section,
    List<Product>? products,
    List<BannerModel>? banners,
    String? errorMSg,
    Product? singleProduct,
    FormzSubmissionStatus? bannerStatus,
    FormzSubmissionStatus? productStatus,
    FormzSubmissionStatus? singleProductStatus,
    String? selectedColor,
    String? selectedSize,
  }) =>
      ThisBlocState(
        section: section ?? this.section,
        banners: banners ?? this.banners,
        bannerStatus: bannerStatus ?? this.bannerStatus,
        productStatus: productStatus ?? this.productStatus,
        singleProductStatus: singleProductStatus ?? this.singleProductStatus,
        products: products ?? this.products,
        errorMSg: errorMSg ?? this.errorMSg,
        singleProduct: singleProduct ?? this.singleProduct,
        selectedColor: selectedColor ?? this.selectedColor,
        selectedSize: selectedSize ?? this.selectedSize,
      );

  @override
  List<Object?> get props => [
        section,
        banners,
        products,
        singleProductStatus,
        errorMSg,
        singleProduct,
        bannerStatus,
        productStatus,
        selectedColor,
        selectedSize,
      ];
}
