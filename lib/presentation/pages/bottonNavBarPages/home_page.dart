import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/core/router/router.dart';
import 'package:stroy_baza/logic/bloc/product_bloc.dart';
import 'package:stroy_baza/logic/bloc/product_event.dart';
import 'package:stroy_baza/logic/bloc/product_state.dart';
import 'package:stroy_baza/presentation/pages/about_product.dart';
import 'package:stroy_baza/presentation/widgets/items/item_of_crousel.dart';
import 'package:stroy_baza/presentation/widgets/items/item_of_product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = "Stroy Baza №1";
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProducts());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final headerHeight = statusBarHeight + 150;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: headerHeight,
            color: const Color.fromRGBO(220, 195, 139, 1),
            child: Column(
              children: [
                SizedBox(height: statusBarHeight + 15),
                Image.asset(
                  'assets/images/h.png',
                  height: 71,
                  width: 77,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Qidirish',
                        hintStyle: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.55),
                          fontFamily: 'Inter',
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color.fromRGBO(0, 0, 0, 0.55),
                          size: 26,
                        ),
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
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<ProductBloc>().add(LoadProducts());
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 20,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color.fromRGBO(136, 121, 121, 0.55),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            _buildCategoryItem("Stroy Baza №1"),
                            _buildCategoryItem("Mebel"),
                            _buildCategoryItem("Gold Klinker"),
                          ],
                        ),
                      ),
                    ),
                    FlutterCarousel(
                      options: FlutterCarouselOptions(
                        height: 184.0,
                        showIndicator: true,
                        initialPage: 0,
                        viewportFraction: 0.9,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                      ),
                      items: [
                        BuildCarouselItem(title: 'Coming soon!'),
                        BuildCarouselItem(
                          imageCarusel: 'assets/images/carusel[1].png',
                        ),
                        BuildCarouselItem(title: 'Coming soon!'),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 14,
                      ),
                      child: Text(
                        "Tavsiya etilgan maxsulotlar",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        if (state is ProductLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color.fromRGBO(220, 195, 139, 1),
                            ),
                          );
                        }

                        if (state is ProductLoadedState) {
                          if (state.products.isEmpty) {
                            return const Center(
                              child: Text('Maxsulotlar topilmadi'),
                            );
                          }

                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 22.0),
                            child: GridView.builder(
                              itemCount: state.products.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 18,
                                crossAxisSpacing: 18,
                                mainAxisExtent: 250,
                              ),
                              itemBuilder: (context, index) {
                                final product = state.products[index];
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AboutProduct(
                                                productId: product.id,
                                              ))),
                                  child: ProductCard(
                                    product: product,
                                    onFavoriteToggle: () {},
                                    onAddToCart: () {},
                                  ),
                                );
                              },
                            ),
                          );
                        }

                        if (state is ProductErrorState) {
                          return Center(
                            child: Text(state.message),
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String title) {
    final isSelected = _selectedCategory == title;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedCategory = title),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected
                  ? const Color.fromRGBO(218, 151, 0, 1)
                  : Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
