import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/app_constats/app_url.dart';
import 'package:stroy_baza/app_constats/assets_model.dart';
import 'package:stroy_baza/core/router/router.dart';
import 'package:stroy_baza/models/product.dart';
import 'package:stroy_baza/presentation/pages/about_product.dart';

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
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AboutProduct(
                    productId: product.id,
                  ))),
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
                      child: Image.network(
                        "${AppUrl.base}${product.image}",
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(AssetsModel.penoplex);
                        },
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
                    product.nameUz,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 22,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Narxi: ${product.variants.isNotEmpty ? product.variants[0].price : '0'} UZS",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: onAddToCart,
                              child: Icon(
                                Icons.add_shopping_cart,
                                color: Colors.amber[700],
                                size: 18,
                              ),
                            ),
                            SizedBox(width: 6),
                            GestureDetector(
                              onTap: onFavoriteToggle,
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.grey,
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
