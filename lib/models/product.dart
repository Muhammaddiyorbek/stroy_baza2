class Product {
  String id = "";
  String img_product = "";
  String category = "";
  String price = "";
  bool liked = false;
  bool basked = false;

  Product(this.category, this.price, this.img_product);

  Product.fromJson(Map<String, dynamic> json)
      : img_product = json['img_post'],
        id = json['id'],
        category = json['caption'],
        price = json['price'],
        liked = json['liked'];

  Map<String, dynamic> toJson() => {
        'img_post': img_product,
        'caption': category,
        'price': price,
        'liked': liked,
        'basked': basked,
      };
}
