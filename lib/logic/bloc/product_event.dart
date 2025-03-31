import 'package:equatable/equatable.dart';
import 'package:stroy_baza/core/utils/enums.dart';

class ProductEvent extends Equatable {
 const ProductEvent();
  @override
  List<Object?> get props => const [];
}

class LoadProducts extends ProductEvent {
  final int branch;
  const LoadProducts(this.branch);
}

class GetBannerEvent extends ProductEvent {
  final int branch;
  const GetBannerEvent({required this.branch});
}

class GetProductByIdEvent extends ProductEvent {
  final String productId;

 const GetProductByIdEvent(this.productId);
}

class LoadProductById extends ProductEvent {
  final int id;

 const LoadProductById(this.id);
}

class SaveSectionEvent extends ProductEvent{
  final SectionEnum section;
 const SaveSectionEvent({required this.section});
}