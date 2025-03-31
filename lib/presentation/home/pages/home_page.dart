import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/core/router/router.dart';
import 'package:stroy_baza/core/utils/enums.dart';
import 'package:stroy_baza/logic/bloc/product_bloc.dart';
import 'package:stroy_baza/logic/bloc/product_event.dart';
import 'package:stroy_baza/logic/bloc/product_state.dart';
import 'package:stroy_baza/presentation/home/widgets/item_of_product.dart';
import 'package:stroy_baza/presentation/search/pages/about_product.dart';
import 'package:stroy_baza/presentation/home/widgets/item_of_crousel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ThisBlocState state;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    state = context.read<ProductBloc>().state;
    context.read<ProductBloc>().add(GetBannerEvent(branch: state.section.branch));
    context.read<ProductBloc>().add(LoadProducts(state.section.branch));
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
      body: BlocBuilder<ProductBloc, ThisBlocState>(
        builder: (context, state) {
          return Column(
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
                    Image.asset(
                      'assets/images/h.png',
                      height: 71,
                      width: 77,
                    ),

                    const SizedBox(height: 10),

                    /// Search
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Qidirish',
                          hintStyle: const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.55), fontFamily: 'Inter'),
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
                  ],
                ),
              ),

              /// Body
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<ProductBloc>().add(LoadProducts(state.section.branch));
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color.fromRGBO(136, 121, 121, 0.55)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ...List.generate(
                                  SectionEnum.values.length,
                                  (i) => _buildCategoryItem(
                                    SectionEnum.values[i],
                                    state,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        if (state.bannerStatus.isInProgress || state.bannerStatus.isInitial) ...{
                          const Center(
                              child: CupertinoActivityIndicator(
                            color: Color.fromRGBO(220, 195, 139, 1),
                          )),
                        },
                        if (state.bannerStatus.isSuccess) ...{
                          FlutterCarousel(
                            options: FlutterCarouselOptions(
                              height: 184.0,
                              showIndicator: true,
                              initialPage: 1,
                              viewportFraction: 0.9,
                              enableInfiniteScroll: false,
                              floatingIndicator: false,
                            ),
                            items: [
                              ...List.generate(
                                state.banners.length,
                                (i) {
                                  final item = state.banners[i];
                                  item.image;
                                  return BuildCarouselItem(image: item.image);
                                },
                              ),
                            ],
                          ),
                        },

                        const Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            "Tavsiya etilgan maxsulotlar",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        if (state.productStatus.isFailure) ...{
                          /// Todo draw failure ui with stateless widget
                        },
                        if (state.productStatus.isInProgress) ...{
                          /// Todo draw failure ui with stateless widget with shimmer
                          const Center(child: CupertinoActivityIndicator(color: Colors.blue)),
                        },

                        if (state.productStatus.isSuccess) ...{
                          if (state.products.isEmpty) ...{
                            const Center(
                              child: Text(
                                "No product available",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          },
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: GridView.builder(
                              itemCount: state.products.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 18,
                                mainAxisExtent: 244,
                              ),
                              itemBuilder: (context, index) {
                                final product = state.products[index];
                                return ProductCard(
                                  product: product,
                                );
                              },
                            ),
                          ),
                        },

                        // BlocBuilder<ProductBloc, ThisBlocState>(
                        //   builder: (context, state) {
                        //     if (state is ProductLoadingState) {
                        //       return const Center(
                        //         child: CircularProgressIndicator(
                        //           color: Color.fromRGBO(220, 195, 139, 1),
                        //         ),
                        //       );
                        //     }
                        //
                        //     if (state is ProductLoadedState) {
                        //       if (state.products.isEmpty) {
                        //         return const Center(
                        //           child: Text('Maxsulotlar topilmadi'),
                        //         );
                        //       }
                        //
                        //
                        //     }
                        //
                        //     if (state is ProductErrorState) {
                        //       return Center(
                        //         child: Text(state.message),
                        //       );
                        //     }
                        //
                        //     return const SizedBox();
                        //   },
                        // ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCategoryItem(SectionEnum section, ThisBlocState state) {
    return Expanded(
      child: GestureDetector(
        onTap: () => context.read<ProductBloc>().add(SaveSectionEvent(section: section)),
        child: SizedBox(
          height: 48,
          child: Center(
            child: Text(
              section.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: state.section.name == section.name ? const Color.fromRGBO(218, 151, 0, 1) : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
