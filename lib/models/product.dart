class Product {
  String id;
  String imgProduct;
  String category;
  String price;
  bool liked;
  bool basket;

  Product({
    required this.id,
    required this.imgProduct,
    required this.category,
    required this.price,
    this.liked = false,
    this.basket = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      imgProduct: json['img_product'] ?? '',
      category: json['category'] ?? '',
      price: json['price'] ?? '',
      liked: json['liked'] ?? false,
      basket: json['basket'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'img_product': imgProduct,
      'category': category,
      'price': price,
      'liked': liked,
      'basket': basket,
    };
  }
}
