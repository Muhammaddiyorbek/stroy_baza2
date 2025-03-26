import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:stroy_baza/logic/bloc/product_bloc.dart';
import 'package:stroy_baza/logic/bloc/product_event.dart';
import 'package:stroy_baza/logic/bloc/product_state.dart';
import 'package:stroy_baza/presentation/home/widgets/items_of_aboutProductPage.dart';

class AboutProduct extends StatefulWidget {
  final int productId;

  const AboutProduct({super.key, required this.productId});

  @override
  State<AboutProduct> createState() => _AboutProductState();
}

class _AboutProductState extends State<AboutProduct> {
  int selectedVariant = 0;
  int selectedMonth = 3;

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProductById(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    // final productId = widget.productId;
    // if (productId == 0) {
    //   return const Center(child: Text('Mahsulot topilmadi'));
    // }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(220, 195, 139, 1),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: -15,
        title: const Text(
          "Mahsulot haqida",
          style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocBuilder<ProductBloc, ThisBlocState>(
        builder: (context, state) {
          if (state.singleProductStatus.isInProgress) {
            return const Center(
              child: CupertinoActivityIndicator(
                color: Color.fromRGBO(220, 195, 139, 1),
              ),
            );
          }

          if (state.singleProductStatus.isFailure) {
            return const Center(
              child: Text("Something went wrong at load data"),
            );
          }

          final product = state.singleProduct;
          final variant = product.variants[selectedVariant];

          if (product.variants.isEmpty) {
            return const Center(
              child: Text('Mahsulot variantlari mavjud emas'),
            );
          }

          final images = [
            "https://back.stroybazan1.uz${variant.image}",
            ...product.variants.map((v) => "https://back.stroybazan1.uz${v.image}")
          ];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  ProductCarusel(images: images),
                  const SizedBox(height: 18),
                  Text(
                    variant.isAvailable ? "Mavjud" : "Mavjud emas",
                    style: TextStyle(
                      color: variant.isAvailable ? Colors.green : Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    product.nameUz,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Rang: ${variant.colorUz}",
                    style: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 6),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        product.variants.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SelectableImage(
                            imagePath: "https://back.stroybazan1.uz${product.variants[index].image}",
                            isSelected: index == selectedVariant,
                            onTap: () => setState(() => selectedVariant = index),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "O'lchami: ${variant.sizeUz}",
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 7),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        product.variants.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SelectableSize(
                            text: product.variants[index].sizeUz,
                            isSelected: index == selectedVariant,
                            onTap: () => setState(() => selectedVariant = index),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "${variant.price} so'm",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                  InstallmentSelection(
                    selectedMonth: selectedMonth,
                    monthlyPayments: {
                      3: variant.monthlyPayment3,
                      6: variant.monthlyPayment6,
                      12: variant.monthlyPayment12,
                      24: variant.monthlyPayment24,
                    },
                    onSelect: (value) => setState(() => selectedMonth = value),
                  ),
                  const SizedBox(height: 10),
                  const DeliveryInfoCard(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
