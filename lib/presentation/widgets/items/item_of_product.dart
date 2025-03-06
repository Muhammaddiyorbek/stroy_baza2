import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/core/router/router.dart';
import 'package:stroy_baza/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onAddToCart;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onFavoriteToggle,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRouteName.aboutProduct);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromRGBO(242, 242, 241, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: 114,
                      width: 132,
                      child: Image.asset(
                        "assets/images/penopleks.png",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    "PENOPLESK",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 22,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              "Narxi: 9.999 UZS",
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            GestureDetector(
                              onTap: () {
                                onAddToCart();
                              },
                              child: Icon(
                                product.basket ? Icons.shopping_cart : Icons.add_shopping_cart,
                                color: Colors.amber[700],
                                size: 18,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            GestureDetector(
                              onTap: () {
                                onFavoriteToggle();
                              },
                              child: Icon(
                                product.liked ? Icons.favorite : Icons.favorite_border,
                                color: product.liked ? Colors.red : Colors.grey,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
