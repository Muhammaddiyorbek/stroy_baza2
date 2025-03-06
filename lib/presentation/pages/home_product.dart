import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/core/router/router.dart';
import 'package:stroy_baza/models/product.dart';
import 'package:stroy_baza/presentation/widgets/items/item_of_product.dart';

class HomeProduct extends StatefulWidget {
  final String category;

  const HomeProduct({super.key, required this.category});

  @override
  State<HomeProduct> createState() => _HomeProductState();
}

class _HomeProductState extends State<HomeProduct> {
  List<Product> products = [
    Product(id: '1', imgProduct: 'assets/images/penopleks.png', category: 'Mebel', price: '120000'),
    Product(id: '2', imgProduct: 'assets/images/penopleks.png', category: 'Stroy Material', price: '250000'),
    Product(id: '3', imgProduct: 'assets/images/penopleks.png', category: 'Gold Klinker', price: '500000'),
    Product(id: '4', imgProduct: 'assets/images/penopleks.png', category: 'Gold Klinker', price: '500000'),
    Product(id: '5', imgProduct: 'assets/images/penopleks.png', category: 'Gold Klinker', price: '500000'),
    Product(id: '6', imgProduct: 'assets/images/penopleks.png', category: 'Gold Klinker', price: '500000'),
  ];

  void _toggleFavorite(Product product) {
    setState(() {
      product.liked = !product.liked;
    });
  }

  void _addToCart(Product product) {
    setState(() {
      product.basket = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(220, 195, 139, 1),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () => context.go(AppRouteName.search),
        ),
        titleSpacing: -15,
        title: const Text(
          "Penoplex",
          style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: GridView.builder(
            itemCount: products.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 18,
              crossAxisSpacing: 18,
              mainAxisExtent: 250, // Kartaning balandligini moslashtirdim
            ),
            itemBuilder: (context, index) => ProductCard(
              product: products[index],
              onFavoriteToggle: () => _toggleFavorite(products[index]),
              onAddToCart: () => _addToCart(products[index]),
            ),
          ),
        ),
      ),
    );
  }
}
