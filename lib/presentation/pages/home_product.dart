import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/logic/bloc/product_bloc.dart';
import 'package:stroy_baza/logic/bloc/product_event.dart';
import 'package:stroy_baza/logic/bloc/product_state.dart';
import 'package:stroy_baza/models/product.dart';

class HomeProduct extends StatefulWidget {
  final String id;

  const HomeProduct({super.key, required this.id});

  @override
  State<HomeProduct> createState() => _HomeProductState();
}

class _HomeProductState extends State<HomeProduct> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProductByIdEvent(widget.id));
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
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(220, 195, 139, 1),
              ),
            );
          }

          if (state is ProductLoadedState && state.products.isNotEmpty) {
            final Product product = state.products.first;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    product.image,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.nameUz,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.descriptionUz,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Variantlar:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: product.variants.length,
                          itemBuilder: (context, index) {
                            final variant = product.variants[index];
                            return Card(
                              child: ListTile(
                                leading: Image.network(
                                  variant.image,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  '${variant.colorUz} - ${variant.sizeUz}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Narxi: ${variant.price}'),
                                    Text(
                                      'Mavjud: ${variant.isAvailable ? "Ha" : "Yo\'q"}',
                                    ),
                                  ],
                                ),
                                trailing: ElevatedButton(
                                  onPressed: () {
                                    // TODO: Add to cart logic
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(220, 195, 139, 1),
                                  ),
                                  child: const Text(
                                    'Savatga',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
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
    );
  }
}
