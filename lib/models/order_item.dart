class OrderItem {
  final int productVariantId;
  final int quantity;
  final String price;
  final int order;
  final int productVariant;

  OrderItem({
    required this.productVariantId,
    required this.quantity,
    required this.price,
    required this.order,
    required this.productVariant,
  });

  Map<String, dynamic> toJson() {
    return {
      "product_variant_id": productVariantId,
      "quantity": quantity,
      "price": price,
      "order": order,
      "product_variant": productVariant,
    };
  }
}
