import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/core/router/router.dart';
import 'package:stroy_baza/presentation/pages/profile_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(220, 195, 139, 1),
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left, color: Colors.black),
              onPressed: () => (),

              ///TODO         context.go(AppRouteName.signUp),
            ),
            const Text(
              "Profile",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Kirish Button
            Container(
              height: 58,
              width: double.infinity,
              margin: EdgeInsets.only(left: 22, right: 22, top: 20, bottom: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 223, 2, 1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color.fromRGBO(213, 213, 213, 1)),
              ),
              child: const Text(
                "Kirish",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),

            _buildCard([
              _buildMenuItem("assets/profile_icons/orders.svg", "Buyurtmalar"),
              _buildMenuItem(
                  "assets/profile_icons/promotions.svg", "Aksiyalar"),
              _buildMenuItem(
                  "assets/profile_icons/favorites.svg", "Sevimlilar"),
            ]),

            /// Shahar va Til Tanlash
            _buildCard([
              _buildMenuItem(
                  "assets/profile_icons/select_city.svg", "Shahar tanlash"),
              _buildMenuItem(
                  "assets/profile_icons/select_language.svg", "Til tanlash"),
            ]),

            /// Qo‘llab-quvvatlash va Chiqish
            _buildCard([
              _buildMenuItem(
                  "assets/profile_icons/support.svg", "Qo‘llab-quvvatlash",
                  hideArrow: true),
              _buildMenuItem("assets/profile_icons/exit.svg", "Chiqish",
                  isRed: true, hideArrow: true),
            ]),

            /// Footer Text
            Padding(
              padding: const EdgeInsets.only(top: 37, bottom: 20),
              child: RichText(
                text: const TextSpan(
                  text: "Powered by ",
                  style: TextStyle(
                      color: Color.fromRGBO(67, 67, 67, 0.81),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                      text: "NSD CORPORATION",
                      style: TextStyle(
                          color: Color.fromRGBO(130, 100, 242, 1),
                          fontWeight: FontWeight.w600),
                    ),
                    TextSpan(text: " v.1.00.0"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfileScreen()));
        },
      ),
    );
  }

  /// Item builder function
  /// Item builder function
  Widget _buildMenuItem(String svgIcon, String title,
      {bool isRed = false, bool hideArrow = false}) {
    return ListTile(
      leading: SvgPicture.asset(svgIcon, width: 24, height: 24),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isRed ? Colors.red : Colors.black,
        ),
      ),
      trailing: hideArrow
          ? null
          : SvgPicture.asset(
              "assets/profile_icons/arrow.svg",
              width: 24,
              height: 24,
            ),
      contentPadding: EdgeInsets.zero,
      // o'chirmaslik kerak shuni
      onTap: () {},
    );
  }

  /// Card builder function
  Widget _buildCard(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color.fromRGBO(213, 213, 213, 1), width: 1),
      ),
      child: Column(children: children),
    );
  }
}
