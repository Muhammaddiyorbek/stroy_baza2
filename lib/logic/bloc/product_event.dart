import 'package:equatable/equatable.dart';
import 'package:stroy_baza/core/utils/enums.dart';
import 'package:stroy_baza/models/product.dart';

class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => const [];
}

class SaveBasket extends ProductEvent {
  final Product product;

  const SaveBasket(this.product);
}

class OrderEvent extends ProductEvent {
  final int user;
  final String cashbackUsed;
  final String deliveryDate;
  final String paymentMethod;
  final String deliveryMethod;
  final String totalAmount;
  final int branch;
  final int part;
  final List OrderModel;

  const OrderEvent(
      {required this.user,
      required this.cashbackUsed,
      required this.deliveryDate,
      required this.paymentMethod,
      required this.deliveryMethod,
      required this.totalAmount,
      required this.branch,
      required this.part,
      required this.OrderModel});
}

class OrderModel {
  final int productVariantId;
  final int quantity;
  final String price;
  final int order;

  const OrderModel({
    required this.productVariantId,
    required this.quantity,
    required this.price,
    required this.order,
  });
}

//   "branch": 0,
//   "items": [
//     {
//       "product_variant_id": 0,
//       "quantity": 1,
//       "price": "string",
//       "order": 0
//     }
//   ],
//   "part": 0

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

class SaveSectionEvent extends ProductEvent {
  final SectionEnum section;

  const SaveSectionEvent({required this.section});
}

class SelectSize extends ProductEvent {
  final String size;

  const SelectSize(this.size);

  @override
  List<Object?> get props => [size];
}

class SelectColor extends ProductEvent {
  final String color;

  const SelectColor(this.color);

  @override
  List<Object?> get props => [color];
}
