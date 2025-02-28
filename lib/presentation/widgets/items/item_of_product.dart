import 'package:flutter/material.dart';
import 'package:stroy_baza/models/product.dart';

class ItemOfProduct extends StatefulWidget {
  final Product product;
  final Function() onFavoriteToggle;
  final Function() onAddToCart;

  const ItemOfProduct({
    Key? key,
    required this.product,
    required this.onFavoriteToggle,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  _ItemOfProductState createState() => _ItemOfProductState();
}

class _ItemOfProductState extends State<ItemOfProduct> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5),
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromRGBO(242, 242, 241, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(widget.product.img_product),
        ),
        Container(
          height: 50,
          width: double.infinity,
          color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.product.category,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Narxi
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "Narxi: ${widget.product.price} UZS",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.black54),
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     IconButton(
                  //       icon: Icon(
                  //         Icons.shopping_cart,
                  //         color: Colors.amber,
                  //         size: 16,
                  //       ),
                  //       onPressed: widget.onAddToCart,
                  //     ),
                  //     IconButton(
                  //       icon: Icon(
                  //         widget.product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  //         color: widget.product.isFavorite ? Colors.red : Colors.grey,
                  //         size: 16,
                  //       ),
                  //       onPressed: widget.onFavoriteToggle,
                  //     ),
                  //   ],
                  // )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
