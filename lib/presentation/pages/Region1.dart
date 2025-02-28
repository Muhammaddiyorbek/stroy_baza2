import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/core/extensions/context_extension.dart';
import 'package:stroy_baza/core/router/router.dart';

class Region1 extends StatefulWidget {
  const Region1({super.key});

  @override
  State<Region1> createState() => _Region1State();
}

class _Region1State extends State<Region1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // RASM
            Image.asset(
              "assets/images/region_logo.png",
              height: 100,
            ),
            const SizedBox(height: 24),

            Text(
              // "Siz Andijon shahridanmisiz ?",
              context.localized.areUFromAnd,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(13, 18, 24, 1),
                fontSize: 18,
                fontWeight: FontWeight.w600, // Qalinroq shrift
              ),
            ),
            const SizedBox(height: 12),

            Text(
              context.localized.detectProductAndDelivery,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(13, 18, 24, 1),
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton(
                  context.localized.nochange,
                  const Color.fromRGBO(228, 228, 225, 1),
                  Colors.black,
                  onTap: () {
                    context.push(AppRouteName.region2);
                  },
                ),
                const SizedBox(width: 12),
                _buildButton(
                  context.localized.yes,
                  const Color.fromRGBO(220, 195, 139, 1),
                  Colors.white,
                  onTap: () {
                    context.push(AppRouteName.init2);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
    String text,
    Color bgColor,
    Color textColor, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        width: 133,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
