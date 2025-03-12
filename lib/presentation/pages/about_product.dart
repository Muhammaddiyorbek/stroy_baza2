import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/core/router/router.dart';
import 'package:stroy_baza/presentation/widgets/items/items_of_aboutProductPage.dart';

class AboutProduct extends StatefulWidget {
  final int productId;

  const AboutProduct({super.key, required this.productId});

  @override
  State<AboutProduct> createState() => _AboutProductState();
}

class _AboutProductState extends State<AboutProduct> {
  int selectedImage = 0;
  int selectedSize = 0;
  int selectedMonth = 3;

  final List<String> images = [
    'assets/images/penopleks.png',
    'assets/images/penopleks.png',
    'assets/images/penopleks.png',
    'assets/images/penopleks.png'
  ];
  final List<String> sizes = ['4×6', '4×6', '4×6', '4×6'];
  final List<int> months = [3, 6, 12, 24];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(220, 195, 139, 1),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: -15,
        title: const Text(
          "Penoplex",
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),

              /// Products, indicator
              ProductCarusel(),

              const SizedBox(height: 18),

              const Text("Mavjud",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),

              const Text(
                "Penoplex Komfort",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),

              const Text(
                "Rang : Ko'k",
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),

              SizedBox(
                height: 6,
              ),

              Row(
                children: List.generate(
                  images.length,
                  (index) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: SelectableImage(
                      imagePath: images[index],
                      isSelected: index == selectedImage,
                      onTap: () => setState(() => selectedImage = index),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                "O'lchami (Metr²): 4x6",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              ),

              const SizedBox(height: 7),

              Row(
                children: List.generate(
                  sizes.length,
                  (index) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: SelectableSize(
                      text: sizes[index],
                      isSelected: index == selectedSize,
                      onTap: () => setState(() => selectedSize = index),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: const Text(
                  "1.116.000 so'm",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),

              const SizedBox(height: 10),

              // 3. Muddatli to‘lov
              InstallmentSelection(
                selectedMonth: selectedMonth,
                onSelect: (value) => setState(() => selectedMonth = value),
              ),
              SizedBox(
                height: 10,
              ),

              DeliveryInfoCard(),
            ],
          ),
        ),
      ),
    );
  }
}
