import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:stroy_baza/models/product.dart';
import 'package:stroy_baza/presentation/widgets/items/item_of_crousel.dart';
import 'package:stroy_baza/presentation/widgets/items/item_of_product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();
  String _selectedCategory = "Stroy Baza №1";

  List<Product> products = [
    Product(id: '1', imgProduct: 'assets/images/penopleks.png', category: 'Mebel', price: '120000'),
    Product(id: '2', imgProduct: 'assets/images/penopleks.png', category: 'Stroy Material', price: '250000'),
    Product(id: '3', imgProduct: 'assets/images/penopleks.png', category: 'Gold Klinker', price: '500000'),
    Product(id: '4', imgProduct: 'assets/images/penopleks.png', category: 'Gold Klinker', price: '500000'),
    Product(id: '5', imgProduct: 'assets/images/penopleks.png', category: 'Gold Klinker', price: '500000'),
    Product(id: '6', imgProduct: 'assets/images/penopleks.png', category: 'Gold Klinker', price: '500000'),
    Product(id: '7', imgProduct: 'assets/images/penopleks.png', category: 'Gold Klinker', price: '500000'),
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
  void dispose() {
    pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double screenWidth = MediaQuery.of(context).size.width;
    double headerHeight = statusBarHeight + 150;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Container(
            width: double.infinity,
            height: headerHeight,
            color: const Color.fromRGBO(220, 195, 139, 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                Image.asset('assets/images/h.png', height: 71, width: 77),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Container(
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Qidirish',
                        prefixIcon: const Icon(Icons.search, size: 26),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Category
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color.fromRGBO(136, 121, 121, 0.55)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18), // Ikkala chekkadan 18px masofa
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Matnlarni yaqinlashtiramiz
                          crossAxisAlignment: CrossAxisAlignment.center, // Vertikal markazlash
                          children: [
                            _buildCategoryItem("Stroy Baza №1"),
                            _buildCategoryItem("Mebel"),
                            _buildCategoryItem("Gold Klinker"),
                          ],
                        ),
                      ),
                    ),
                  ),


                  /// Carousel
                  FlutterCarousel(
                    options: FlutterCarouselOptions(
                      height: screenWidth > 600 ? 250.0 : 184.0,
                      viewportFraction: screenWidth > 600 ? 0.7 : 0.9,
                      showIndicator: false,
                      initialPage: 1,
                    ),
                    items: [
                      BuildCarouselItem(title: 'Coming soon!'),
                      BuildCarouselItem(imageCarusel: 'assets/images/carusel[1].png'),
                      BuildCarouselItem(title: 'Coming soon!'),
                    ],
                  ),

                  /// Tavsiya etilgan maxsulotlar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                    child: Text(
                      "Tavsiya etilgan maxsulotlar",
                      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),

                  /// GridView
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
                        return GridView.builder(
                          itemCount: products.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            mainAxisSpacing: 18,
                            crossAxisSpacing: 18,
                            mainAxisExtent: 250,
                          ),
                          itemBuilder: (context, index) => ProductCard(
                            product: products[index],
                            onFavoriteToggle: () => setState(() => products[index].liked = !products[index].liked),
                            onAddToCart: () => setState(() => products[index].basket = true),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Category
  Widget _buildCategoryItem(String title) {
    bool isSelected = _selectedCategory == title;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = title),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Color.fromRGBO(218, 151, 0, 1) : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

}
