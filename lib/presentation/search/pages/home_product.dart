import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/logic/bloc/product_bloc.dart';
import 'package:stroy_baza/logic/bloc/product_event.dart';
import 'package:stroy_baza/logic/bloc/product_state.dart';

class HomeProduct extends StatefulWidget {
  const HomeProduct({super.key});

  @override
  State<HomeProduct> createState() => _HomeProductState();
}

class _HomeProductState extends State<HomeProduct> {
  late final ThisBlocState state;
  
  
  @override
  void initState() {
    state = context.read<ProductBloc>().state;
    context.read<ProductBloc>().add(LoadProducts(state.section.branch));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(220, 195, 139, 1),
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Maxsulot haqida',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
            child: Container(
              color: Colors.red,
              height: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
            child: Container(
              color: Colors.red,
              height: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
            child: Container(
              color: Colors.red,
              height: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
            child: Container(
              color: Colors.red,
              height: 50,
            ),
          ),
        ],
      ),
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
    );
  }
}
