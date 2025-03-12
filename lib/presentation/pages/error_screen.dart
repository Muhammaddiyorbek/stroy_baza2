import 'package:flutter/material.dart';
import 'package:stroy_baza/app_constats/assets_model.dart';
import 'package:stroy_baza/presentation/pages/no_internet_screen.dart';

class ErrorScreen extends StatelessWidget {
  static const routeName = '/error-404';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFED766), // Orqa fon rangi
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetsModel.error_404, // Sizning rasm yo‘lingiz
              width: double.infinity,
            ),
            SizedBox(height: 20),
            Text(
              "404 ERROR",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Sahifa topilmadi",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NoInternetScreen()));
        },
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
