import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();
  String _selectedCategory = "Stroy Baza №1";

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double headerHeight = statusBarHeight + 150; // Status bar + 150px sariq header

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Container(
            width: double.infinity,
            height: headerHeight,
            color: const Color.fromRGBO(220, 195, 139, 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                Image.asset(
                  'assets/images/h.png',
                  height: 71,
                  width: 77,
                ),
                GestureDetector(onTap: () {}, child: const SizedBox(height: 10)),

                /// Search
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Container(
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Qidirish',
                        hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.55)),
                        prefixIcon: const Icon(Icons.search, color: Color.fromRGBO(0, 0, 0, 0.55)),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Category
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color.fromRGBO(136, 121, 121, 0.55)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  _buildCategoryItem("Stroy Baza №1"),
                  _buildCategoryItem("Mebel"),
                  _buildCategoryItem("Gold Klinker"),
                ],
              ),
            ),
          ),

          /// Carusel

          Container(
            margin: EdgeInsets.symmetric(horizontal: 22),
            height: 183,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          ///
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            child: Text(
              "Tavsiya etilgan maxsulotlar",
              style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),

          ///Grid Product
        ],
      ),
    );
  }

  /// Category
  Widget _buildCategoryItem(String title) {
    bool isSelected = _selectedCategory == title;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedCategory = title),
        child: Container(
          alignment: Alignment.center, // Matnni o‘rtaga joylash
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Color.fromRGBO(218, 151, 0, 1) : Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
