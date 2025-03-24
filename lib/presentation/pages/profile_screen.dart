import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
  static const routeName = '/profile-screen';
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFD4B37F),
        elevation: 0,
        title: Text("Profile", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileCard(),
            SizedBox(height: 16),
            _buildSettingsCard([
              _buildListTile(
                icon: Icons.account_balance,
                title: "Mening muddatli to’lovlarim",
                onTap: () {
                  // TODO: Shu yerga funksiyani qo‘shing
                },
              ),
              _buildListTile(
                icon: Icons.percent,
                title: "Aksiyalar",
                onTap: () {
                  // TODO: Funksiyani qo‘shing
                },
              ),
              _buildListTile(
                icon: Icons.favorite_border,
                title: "Sevimlilar",
                onTap: () {
                  // TODO: Funksiyani qo‘shing
                },
              ),
            ]),
            SizedBox(height: 16),
            _buildSettingsCard([
              _buildListTile(
                icon: Icons.location_on,
                title: "Shahar tanlash",
                onTap: () {
                  // TODO: Funksiya qo‘shish
                },
              ),
              _buildListTile(
                icon: Icons.language,
                title: "Til tanlash",
                onTap: () {
                  // TODO: Funksiya qo‘shish
                },
              ),
            ]),
            SizedBox(height: 16),
            _buildSettingsCard([
              _buildListTile(
                icon: Icons.info,
                title: "Qo’llab-quvvatlash",
                onTap: () {
                  // TODO: Qo‘llab-quvvatlash sahifasiga o‘tish
                },
              ),
              _buildListTile(
                icon: Icons.exit_to_app,
                title: "Chiqish",
                textColor: Colors.red,
                onTap: () {
                  _showLogoutDialog(context);
                },
              ),
            ]),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.pushNamed(context, ErrorScreen.routeName);
        },
        child: Icon(Icons.navigate_next),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(Icons.account_circle, size: 48, color: Colors.grey),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nuraliyev Muhammad Sodiq",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "+998 90 762 92 82",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color textColor = Colors.black,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, color: textColor),
          title: Text(title, style: TextStyle(color: textColor)),
          trailing: Icon(Icons.chevron_right, color: Colors.grey),
        ),
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
}
