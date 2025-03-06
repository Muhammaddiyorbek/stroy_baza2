import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/core/router/router.dart';

class Init2 extends StatefulWidget {
  const Init2({super.key});

  @override
  State<Init2> createState() => _Init2State();
}

class _Init2State extends State<Init2> {
  List<Map<String, String>> contents = [
    {"image": "assets/images/mebel.png", "title": "Mebel"},
    {"image": "assets/images/stroy.png", "title": "Stroy Baza №1"},
    {"image": "assets/images/klinker.png", "title": "Gold Klinker"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              contents.length,
                  (index) {
                final item = contents[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 31.0, vertical: 10),
                  child: MaterialButton(
                    onPressed: () => context.go(AppRouteName.main),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: const BorderSide(
                        color: Color.fromRGBO(220, 195, 139, 1),
                        width: 1.5,
                      ),
                    ),
                    height: 60,
                    child: Row(
                      children: [
                        const SizedBox(width: 30),
                        Image.asset(item["image"]!),
                        const SizedBox(width: 31),
                        Text(
                          item["title"]!,
                          style: const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
