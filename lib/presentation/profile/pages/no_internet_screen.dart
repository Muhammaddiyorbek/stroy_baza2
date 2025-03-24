import 'package:flutter/material.dart';
import 'package:stroy_baza/app_constats/assets_model.dart';
import 'package:stroy_baza/presentation/profile/pages/shop_list_screen.dart';

class NoInternetScreen extends StatelessWidget {
  static const routeName = '/no-internet-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AssetsModel.no_wifi,
                width: 200,
              ),
              SizedBox(height: 24),
              Text(
                "Ulanishda xatolik yuz berdi",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Internet provayderiga ulanganligingizni tekshiring!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ShopListScreen()));
        },
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
