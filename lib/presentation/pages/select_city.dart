import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/core/router/router.dart';

class SelectCity extends StatefulWidget {
  const SelectCity({super.key});

  @override
  State<SelectCity> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(220, 195, 139, 1),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () => context.go(AppRouteName.profile),
        ),
        titleSpacing: -15,
        title: const Text(
          "Shaharni tanlash",
          style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            _buildCityButton("Toshkent shahri"),
            const SizedBox(height: 30),
            _buildCityButton("Andijon shahri"),
            const SizedBox(height: 30),
            _buildCityButton("Farg’ona shahri"),
            const SizedBox(height: 30),
            _buildCityButton("Namangan shahri"),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(220, 195, 139, 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  context.push(AppRouteName.savatcha);
                },
                child: const Text(
                  "O'zgertirish",
                  style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCityButton(String cityName) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        cityName,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
