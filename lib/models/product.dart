import 'dart:convert';

List<Product> productsFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productsToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Product singleProductFromJson(String str) => Product.fromJson(json.decode(str));

String singleProductToJson(Product data) => json.encode(data.toJson());

class Product {
  final int id;
  final int branch;
  final int category;
  final List<Variant> variants;
  final String nameUz;
  final String nameRu;
  final String nameEn;
  final bool isAvailable;
  final String descriptionUz;
  final String descriptionRu;
  final String descriptionEn;
  final String image;

  const Product({
    required this.id,
    required this.variants,
    required this.branch,
    required this.nameUz,
    required this.nameRu,
    required this.nameEn,
    required this.isAvailable,
    required this.descriptionUz,
    required this.descriptionRu,
    required this.descriptionEn,
    required this.image,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] ?? 0,
        branch: json["branch"] ?? 0,
        category: json["category"] ?? 0,
        variants: json["variants"] != null ? List<Variant>.from(json["variants"].map((x) => Variant.fromJson(x))) : [],
        nameUz: json["name_uz"] ?? '',
        nameRu: json["name_ru"] ?? '',
        nameEn: json["name_en"] ?? '',
        isAvailable: json["is_available"] ?? false,
        descriptionUz: json["description_uz"] ?? '',
        descriptionRu: json["description_ru"] ?? '',
        descriptionEn: json["description_en"] ?? '',
        image: json["image"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branch": branch,
        "category": category,
        "variants": variants.map((x) => x.toJson()).toList(),
        "name_uz": nameUz,
        "name_ru": nameRu,
        "name_en": nameEn,
        "is_available": isAvailable,
        "description_uz": descriptionUz,
        "description_ru": descriptionRu,
        "description_en": descriptionEn,
        "image": image,
      };
}

class Variant {
  int id;
  String colorUz;
  String colorRu;
  String colorEn;
  String sizeUz;
  String sizeRu;
  String sizeEn;
  String price;
  bool isAvailable;
  String image;
  String monthlyPayment3;
  String monthlyPayment6;
  String monthlyPayment12;
  String monthlyPayment24;
  int product;
  String descriptionUz;
  String descriptionRu;
  String descriptionEn;

  Variant({
    required this.id,
    required this.colorUz,
    required this.colorRu,
    required this.colorEn,
    required this.sizeUz,
    required this.sizeRu,
    required this.sizeEn,
    required this.price,
    required this.isAvailable,
    required this.image,
    required this.monthlyPayment3,
    required this.monthlyPayment6,
    required this.monthlyPayment12,
    required this.monthlyPayment24,
    required this.product,
    required this.descriptionUz,
    required this.descriptionRu,
    required this.descriptionEn,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        id: json["id"] ?? 0,
        colorUz: json["color_uz"] ?? '',
        colorRu: json["color_ru"] ?? '',
        colorEn: json["color_en"] ?? '',
        sizeUz: json["size_uz"] ?? '',
        sizeRu: json["size_ru"] ?? '',
        sizeEn: json["size_en"] ?? '',
        price: json["price"] ?? '0',
        isAvailable: json["is_available"] ?? false,
        image: json["image"] ?? '',
        monthlyPayment3: json["monthly_payment_3"] ?? '0',
        monthlyPayment6: json["monthly_payment_6"] ?? '0',
        monthlyPayment12: json["monthly_payment_12"] ?? '0',
        monthlyPayment24: json["monthly_payment_24"] ?? '0',
        product: json["product"] ?? 0,
        descriptionUz: json["description_uz"] ?? '',
        descriptionRu: json["description_ru"] ?? '',
        descriptionEn: json["description_en"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "color_uz": colorUz,
        "color_ru": colorRu,
        "color_en": colorEn,
        "size_uz": sizeUz,
        "size_ru": sizeRu,
        "size_en": sizeEn,
        "price": price,
        "is_available": isAvailable,
        "image": image,
        "monthly_payment_3": monthlyPayment3,
        "monthly_payment_6": monthlyPayment6,
        "monthly_payment_12": monthlyPayment12,
        "monthly_payment_24": monthlyPayment24,
        "product": product,
        "description_uz": descriptionUz,
        "description_ru": descriptionRu,
        "description_en": descriptionEn,
      };
}
