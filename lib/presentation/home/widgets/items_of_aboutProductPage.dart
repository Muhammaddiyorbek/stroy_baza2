import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

/// Product images and indicator
class ProductCarusel extends StatelessWidget {
  final List<String> images;

  const ProductCarusel({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      options: FlutterCarouselOptions(
        height: 184.0,
        showIndicator: true,
        initialPage: 0,
        viewportFraction: 0.9,
        enableInfiniteScroll: false,
        autoPlay: false,
      ),
      items: images
          .map((imageUrl) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "https://back.stroybazan1.uz/$imageUrl",
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                          color: const Color.fromRGBO(220, 195, 139, 1),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(Icons.error_outline, color: Colors.red),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}

/// 1. Tanlanadigan ranglar
class SelectableColor extends StatelessWidget {
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableColor({super.key, required this.imagePath, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 62,
          height: 80,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(242, 242, 241, 0.65),
            border: isSelected ? Border.all(color: const Color.fromRGBO(190, 160, 134, 1), width: 1.5) : null,
            borderRadius: BorderRadius.circular(5),
          ),
          child: CachedNetworkImage(
            imageUrl: imagePath,
            fit: BoxFit.contain,
            placeholder: (context, url) => const Center(child: CupertinoActivityIndicator()), // Loading indicator
            errorWidget: (context, url, error) => const Icon(Icons.error), // Error icon if image fails to load
          )),
    );
  }
}

/// 2. Tanlanadigan o‘lchamlar
class SelectableSize extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableSize({super.key, required this.text, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 62,
        height: 62,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(247, 247, 246, 1),
          border: isSelected ? Border.all(color: const Color.fromRGBO(190, 160, 134, 1), width: 1.5) : null,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}

/// Muddatli to‘lov tanlash
class InstallmentSelection extends StatelessWidget {
  final int selectedMonth;
  final ValueChanged<int> onSelect;

  const InstallmentSelection({
    super.key,
    required this.selectedMonth,
    required this.onSelect,
    required Map<int, String> monthlyPayments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(242, 242, 241, 1),
        border: Border.all(
          color: const Color.fromRGBO(213, 213, 213, 1),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            height: 26,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(213, 213, 213, 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [3, 6, 12, 24].map((month) {
                bool isSelected = month == selectedMonth;
                return GestureDetector(
                  onTap: () => onSelect(month),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "$month oy",
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                height: 28,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(254, 242, 157, 1),
                  borderRadius: BorderRadius.circular(2.5),
                ),
                child: const Text(
                  "135.652 so’m",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "x 24oy",
                style: TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DeliveryInfoCard extends StatelessWidget {
  const DeliveryInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Siz buyurtmani 3 oydan 24 oygacha muddatli to’lov evaziga xarid qilishingiz mumkin.",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color.fromRGBO(213, 213, 213, 1),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "Yetkazib berish ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                      TextSpan(text: "1 kun ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                      TextSpan(text: "ichida", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                SizedBox(height: 4),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "Agar ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                      TextSpan(text: "5mln ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: "so‘mdan ortiq mahsulotga buyurtma bersangiz yetkazib berish VODIY bo‘ylab bepul.",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Divider(height: 24, thickness: 1, color: Color.fromRGBO(213, 213, 213, 1)),
                Text(
                    "Muddati to‘lovni rasmiylashtirayotganingizda bizdan va hamkorlarimizdan eng maqbul takliflarga ega bo‘lishingiz mumkin.",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PaymentIcon(asset: 'assets/payment_icons/image (1).png'),
                    PaymentIcon(asset: 'assets/payment_icons/image (2).png'),
                    PaymentIcon(asset: 'assets/payment_icons/image (3).png'),
                    PaymentIcon(asset: 'assets/payment_icons/image (5).png'),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(220, 195, 139, 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {},
            child: const Text("Savatchaga qo‘shish",
                style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 36),
        Center(
          child: RichText(
            text: const TextSpan(
              text: "Powered by ",
              style: TextStyle(color: Color.fromRGBO(67, 67, 67, 0.81), fontSize: 16, fontWeight: FontWeight.w500),
              children: [
                TextSpan(
                  text: "NSD CORPORATION",
                  style: TextStyle(color: Color.fromRGBO(130, 100, 242, 1), fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class PaymentIcon extends StatelessWidget {
  final String asset;

  const PaymentIcon({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: Image.asset(asset, fit: BoxFit.cover),
      ),
    );
  }
}
