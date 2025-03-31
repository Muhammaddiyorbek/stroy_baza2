import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/app_constats/app_url.dart';
import 'package:stroy_baza/app_constats/assets_model.dart';
import 'package:stroy_baza/core/router/router.dart';
import 'package:stroy_baza/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  //onTap: () => context.push(AppRouteName.aboutProduct),

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => context.go("${AppRouteName.main}/${AppRouteName.aboutProduct}", extra: product),
            child: Container(
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(242, 242, 241, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
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
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.nameUz,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 22,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Narxi: ${product.variants.isNotEmpty ? product.variants[0].price : '0'} UZS",
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => log("like"),
                            child: const Icon(
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
    );
  }
}
