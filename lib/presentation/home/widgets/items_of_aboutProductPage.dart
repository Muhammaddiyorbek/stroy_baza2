import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stroy_baza/logic/bloc/product_bloc.dart';
import 'package:stroy_baza/logic/bloc/product_event.dart';
import 'package:stroy_baza/logic/bloc/product_state.dart';

class AboutProductCarusel extends StatefulWidget {
  final List<String> images;

  const AboutProductCarusel({
    super.key,
    required this.images,
  });

  @override
  _AboutProductCaruselState createState() => _AboutProductCaruselState();
}

class _AboutProductCaruselState extends State<AboutProductCarusel> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 188,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                final imageUrl = widget.images[index];
                final fullUrl = imageUrl.startsWith('http')
                    ? imageUrl
                    : "https://back.stroybazan1.uz${imageUrl.startsWith('/') ? imageUrl : '/$imageUrl'}";

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      fullUrl,
                      fit: BoxFit.contain,
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
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          SmoothPageIndicator(
            controller: _controller,
            count: widget.images.length,
            effect: CustomizableEffect(
              activeDotDecoration: DotDecoration(
                width: 16,
                height: 16,
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
                dotBorder: const DotBorder(
                  color: Color.fromRGBO(0, 0, 0, 0.55),
                  width: 1,
                ),
              ),
              dotDecoration: DotDecoration(
                width: 16,
                height: 16,
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                dotBorder: const DotBorder(
                  color: Color.fromRGBO(0, 0, 0, 0.55),
                  width: 1,
                ),
              ),
              spacing: 8,
            ),
          ),
        ],
      ),
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
            placeholder: (context, url) => const Center(child: CupertinoActivityIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
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
  final Map<int, String> monthlyPayments;

  const InstallmentSelection({
    super.key,
    required this.selectedMonth,
    required this.onSelect,
    required this.monthlyPayments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F1),
        border: Border.all(
          color: const Color(0xFFD5D5D5),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 26,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFD5D5D5),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [3, 6, 12, 24].map((month) {
                bool isSelected = month == selectedMonth;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onSelect(month),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
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
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 8,
              ),
              Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF29D),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Center(
                  child: Text(
                    "${monthlyPayments[selectedMonth]} so’m",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                "x $selectedMonth oy",
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
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
                  spacing: 13,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PaymentIcon(asset: 'assets/payment_icons/image (5).png'),
                    PaymentIcon(asset: 'assets/payment_icons/image (3).png'),
                    PaymentIcon(asset: 'assets/payment_icons/image (1).png'),
                    PaymentIcon(asset: 'assets/payment_icons/image (2).png'),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
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
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Image.asset(asset, fit: BoxFit.cover)),
      ),
    );
  }
}
