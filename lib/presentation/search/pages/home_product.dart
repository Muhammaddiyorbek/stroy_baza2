import 'package:flutter/material.dart';

class HomeProduct extends StatelessWidget {
  final String categoryName; // category nomi

  const HomeProduct({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(220, 195, 139, 1),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: -15,
        title: Text(
          categoryName, // Bu yerda category nomini ko'rsatamiz
          style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      body: const Center(child: Text("Mahsulotlar...")),
    );
  }
}

      // body: BlocBuilder<ProductBloc, ThisBlocState>(
      //   builder: (context, state) {
      //     return Column(
      //       children: [
      //         if (state.productStatus.isSuccess) ...{
      //           if (state.products.isEmpty) ...{
      //             const Center(
      //               child: Text(
      //                 "No product available",
      //                 style: TextStyle(color: Colors.black),
      //               ),
      //             ),
      //           },
      //           Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 22.0),
      //             child: GridView.builder(
      //               itemCount: state.products.length,
      //               shrinkWrap: true,
      //               physics: const NeverScrollableScrollPhysics(),
      //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //                 crossAxisCount: 2,
      //                 mainAxisSpacing: 18,
      //                 crossAxisSpacing: 18,
      //                 mainAxisExtent: 250,
      //               ),
      //               itemBuilder: (context, index) {
      //                 final product = state.products[index];
      //                 return GestureDetector(
      //                   onTap: () => Navigator.push(
      //                     context,
      //                     MaterialPageRoute(builder: (context) => AboutProduct(productId: product.id)),
      //                   ),
      //                   child: ProductCard(
      //                     product: product,
      //                     onFavoriteToggle: () {},
      //                   ),
      //                 );
      //               },
      //             ),
      //           ),
      //         },
      //       ],
      //     );
      //   },
      // ),

