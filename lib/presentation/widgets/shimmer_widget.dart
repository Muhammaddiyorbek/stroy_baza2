import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shape;

  const ShimmerWidget({
    super.key,
    required this.width,
    required this.height,
    this.shape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: shape,
        ),
      ),
    );
  }
}

class ShimmerProductCard extends StatelessWidget {
  const ShimmerProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(242, 242, 241, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: ShimmerWidget(
                width: 132,
                height: 114,
                shape: Border.all(width: 10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(height: 6),
                ShimmerWidget(width: 80, height: 12), // Mahsulot nomi
                SizedBox(height: 8),
                ShimmerWidget(width: 100, height: 12), // Narx
              ],
            ),
          )
        ],
      ),
    );
  }
}
