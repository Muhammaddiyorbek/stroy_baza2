class OrderItemRequestModel {
  final int productVariantId;
  final int quantity;
  final int month;

  OrderItemRequestModel({
    required this.productVariantId,
    required this.quantity,
    required this.month,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_variant_id': productVariantId,
      'quantity': quantity,
      'month': month,
    };
  }
}
