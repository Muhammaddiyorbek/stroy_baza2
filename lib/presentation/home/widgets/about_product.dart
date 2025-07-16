import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:stroy_baza/logic/bloc/product_bloc.dart';
import 'package:stroy_baza/logic/bloc/product_event.dart';
import 'package:stroy_baza/logic/bloc/product_state.dart';
import 'package:stroy_baza/models/product.dart';
import 'package:stroy_baza/presentation/home/widgets/items_of_aboutProductPage.dart';

class AboutProduct extends StatefulWidget {
  final Product product;

  const AboutProduct({super.key, required this.product});

  @override
  State<AboutProduct> createState() => _AboutProductState();
}

class _AboutProductState extends State<AboutProduct> {
  late Map<String, List<Variant>> groupedByColor;
  late List<String> colors;
  String selectedColor = "";
  String? selectedSize;
  int selectedMonth = 3;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  void _loadProduct() {
    context.read<ProductBloc>().add(LoadProductById(widget.product.id));
  }

  Future<void> _onRefresh() async {
    setState(() {
      selectedColor = "";
      selectedSize = null;
      selectedMonth = 3;
    });
    _loadProduct();
  }

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
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: const SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 300),
                    child: Text("Mahsulot yuklanishda xatolik yuz berdi"),
                  ),
                ),
              ),
            );
          }

          final product = state.singleProduct;
          if (product.variants.isEmpty) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: const SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 300),
                    child: Text('Mahsulot variantlari mavjud emas'),
                  ),
                ),
              ),
            );
          }

          // Ranglar bo'yicha guruhlash
          groupedByColor = {};
          for (var v in product.variants) {
            groupedByColor.putIfAbsent(v.colorUz, () => []).add(v);
          }
          colors = groupedByColor.keys.toList();

          // Default tanlov
          if (selectedColor.isEmpty || !colors.contains(selectedColor)) {
            selectedColor = colors.first;
            selectedSize = null;
          }

          List<Variant> currentVariants = groupedByColor[selectedColor] ?? [];

          if (currentVariants.isNotEmpty) {
            final images = currentVariants.map((v) => "https://back.stroybazan1.uz${v.image}").toList();
            final selectedVariant = selectedSize == null
                ? currentVariants.first
                : currentVariants.firstWhere(
                    (v) => v.sizeUz == selectedSize,
                    orElse: () => currentVariants.first,
                  );
            final sizes = currentVariants.map((v) => v.sizeUz).toSet().toList();

            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      AboutProductCarusel(images: images),
                      const SizedBox(height: 18),
                      Text(
                        selectedVariant.isAvailable ? "Mavjud" : "Mavjud emas",
                        style: TextStyle(
                          color: selectedVariant.isAvailable ? Colors.green : Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        product.nameUz,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Rang: ${selectedVariant.colorUz}",
                        style: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 6),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: colors.map((color) {
                            final image = groupedByColor[color]!.first.image;
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SelectableColor(
                                imagePath: "https://back.stroybazan1.uz$image",
                                isSelected: selectedColor == color,
                                onTap: () {
                                  setState(() {
                                    selectedColor = color;
                                    selectedSize = null;
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "O'lchami: ${selectedVariant.sizeUz}",
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 7),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: sizes.map((size) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SelectableSize(
                                text: size,
                                isSelected: selectedSize == size,
                                onTap: () {
                                  setState(() {
                                    selectedSize = size;
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          "${selectedVariant.price} so'm",
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      InstallmentSelection(
                        selectedMonth: selectedMonth,
                        monthlyPayments: {
                          3: selectedVariant.monthlyPayment3,
                          6: selectedVariant.monthlyPayment6,
                          12: selectedVariant.monthlyPayment12,
                          24: selectedVariant.monthlyPayment24,
                        },
                        onSelect: (value) => setState(() => selectedMonth = value),
                      ),
                      const SizedBox(height: 10),
                      const DeliveryInfoCard(),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(220, 195, 139, 1),
                            disabledBackgroundColor: const Color.fromRGBO(220, 195, 139, 1), // Qo‘shildi
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            if (state.saveStatus != FormzSubmissionStatus.inProgress) {
                              context.read<ProductBloc>().add(SaveBasket(state.singleProduct));
                            }
                          },
                          child: state.saveStatus == FormzSubmissionStatus.inProgress
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                  ),
                                )
                              : const Text(
                                  "Savatchaga qo‘shish",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: const SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 300),
                    child: Text("No data available, please refresh the page"),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
