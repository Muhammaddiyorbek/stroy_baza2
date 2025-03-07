import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/core/router/router.dart';

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
              onPressed: () => Navigator.pop(context),
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
            GestureDetector(
              onTap: () {
                context.push(AppRouteName.signUp);
              },
              child: _buildButton("Kirish", Color.fromRGBO(255, 223, 2, 1)),
            ),

            _buildCard([
              _buildMenuItem("assets/profile_icons/orders.svg", "Buyurtmalar", onTap: () => context.push(AppRouteName.buyurtmalar)),
              _buildMenuItem("assets/profile_icons/promotions.svg", "Aksiyalar", onTap: () => context.push(AppRouteName.aksiyalar)),
              _buildMenuItem("assets/profile_icons/favorites.svg", "Sevimlilar", onTap: () => context.push(AppRouteName.sevimlilar)),
            ]),

            _buildCard([
              _buildMenuItem("assets/profile_icons/select_city.svg", "Shahar tanlash", onTap: () => context.push(AppRouteName.select_city)),
              _buildMenuItem("assets/profile_icons/select_language.svg", "Til tanlash", onTap: () => context.push(AppRouteName.select_lang)),
            ]),

            _buildCard([
              _buildMenuItem("assets/profile_icons/support.svg", "Qo‘llab-quvvatlash", hideArrow: true),
              _buildMenuItem("assets/profile_icons/exit.svg", "Chiqish", isRed: true, hideArrow: true, onTap: () => _showLogoutDialog(context)),
            ]),

            Padding(
              padding: const EdgeInsets.only(top: 37, bottom: 20),
              child: RichText(
                text: const TextSpan(
                  text: "Powered by ",
                  style: TextStyle(color: Color.fromRGBO(67, 67, 67, 0.81), fontSize: 16, fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                      text: "NSD CORPORATION",
                      style: TextStyle(color: Color.fromRGBO(130, 100, 242, 1), fontWeight: FontWeight.w600),
                    ),
                    TextSpan(text: " v.1.00.0"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }





  Widget _buildButton(String text, Color color) {
    return Container(
      height: 58,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromRGBO(213, 213, 213, 1)),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }


  Widget _buildMenuItem(String svgIcon, String title, {bool isRed = false, bool hideArrow = false, VoidCallback? onTap}) {
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
          : SvgPicture.asset("assets/profile_icons/arrow.svg", width: 24, height: 24),
      onTap: onTap,
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromRGBO(213, 213, 213, 1), width: 1),
      ),
      child: Column(children: children),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(30),
          actionsPadding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: const Text(
            "Xaqiqatan ham accountdan chiqilsinmi?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ha", style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Yo‘q", style: TextStyle(color: Colors.black, fontSize: 18)),
            ),
          ],
        );
      },
    );
  }
}
