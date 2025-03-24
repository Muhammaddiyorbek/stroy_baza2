import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stroy_baza/presentation/profile/pages/aksiyalar_screen.dart';
import 'package:stroy_baza/presentation/basked/pages/orders_screen.dart';
import 'package:stroy_baza/presentation/profile/pages/phone_input.dart';
import 'package:stroy_baza/presentation/profile/pages/shop_list_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Kirish Button
            InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneInputScreen())),
              child: Container(
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
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            _buildCard([
              _buildMenuItem(
                "assets/profile_icons/orders.svg",
                "Buyurtmalar",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrdersScreen(),
                  ),
                ),
              ),
              _buildMenuItem(
                "assets/profile_icons/promotions.svg",
                "Keshbeklar",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AksiyalarScreen(),
                  ),
                ),
              ),
              _buildMenuItem("assets/profile_icons/favorites.svg", "Sevimlilar"),
            ]),

            /// Shahar va Til Tanlash
            _buildCard([
              _buildMenuItem("assets/profile_icons/select_city.svg", "Shahar tanlash"),
              _buildMenuItem("assets/profile_icons/select_language.svg", "Til tanlash"),
            ]),

            /// Qo‘llab-quvvatlash va Chiqish
            _buildCard([
              _buildMenuItem("assets/profile_icons/support.svg", "Qo‘llab-quvvatlash", hideArrow: true, onTap: _showSupportModal),
              _buildMenuItem("assets/profile_icons/exit.svg", "Chiqish",
                  isRed: true, hideArrow: true, onTap: () => _showLogoutDialog(context)),
            ]),

            /// Footer Text
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ShopListScreen()));
        },
        child: Icon(Icons.location_on),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(30),
          actionsPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Text(
            "Xaqiqatan ham accountdan chiqilsinmi?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // TODO: Chiqish logikasini qo‘shish
              },
              child: Text("Ha", style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Yo‘q", style: TextStyle(color: Colors.black, fontSize: 18)),
            ),
          ],
        );
      },
    );
  }

  void _showSupportModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Qo'llab-quvvatlash xizmati",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("+998 90 762 92 82"),
              subtitle: const Text("Savolingiz bormi? Qo'ng'iroq qiling"),
              trailing: const Icon(Icons.phone, color: Colors.black),
              onTap: () => launchUrl(Uri.parse('tel:+998907629282')),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("+998 90 123 45 67"),
              subtitle: const Text("Ishonch telefoni"),
              trailing: const Icon(Icons.phone, color: Colors.black),
              onTap: () => launchUrl(Uri.parse('tel:+998901234567')),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSocialButton('Instagram', FontAwesomeIcons.instagram),
                _buildSocialButton('Youtube', FontAwesomeIcons.youtube),
                _buildSocialButton('Telegram', FontAwesomeIcons.telegram),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(String label, IconData icon) {
    return InkWell(
      onTap: () {
        switch (label) {
          case 'Instagram':
            launchUrl(Uri.parse('https://instagram.com/stroybaza'));
            break;
          case 'Youtube':
            launchUrl(Uri.parse('https://youtube.com/@stroybaza'));
            break;
          case 'Telegram':
            launchUrl(Uri.parse('https://t.me/stroybaza'));
            break;
        }
      },
      child: Column(
        children: [
          Icon(icon, size: 30),
          const SizedBox(height: 4),
          Text(label),
        ],
      ),
    );
  }

  /// Item builder function
  /// Item builder function
  Widget _buildMenuItem(String svgIcon, String title, {bool isRed = false, bool hideArrow = false, Function? onTap}) {
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
      onTap: onTap != null ? () => onTap() : null,
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
