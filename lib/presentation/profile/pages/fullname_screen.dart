import 'package:flutter/material.dart';
import 'package:stroy_baza/presentation/profile/pages/error_screen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
  static const routeName = '/registration';
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 150),
            Text(
              "Ism",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5),
            TextField(
              style: TextStyle(fontSize: 18, height: 1.5),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                hintText: "Ismingizni kiriting",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Familiya",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5),
            TextField(
              style: TextStyle(fontSize: 18, height: 1.5),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                hintText: "Familiyangizni kiriting",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(255, 223, 2, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), side: BorderSide(color: Colors.grey, width: 0.5)),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ErrorScreen()));
                },
                child: Text(
                  'Davom etish',
                  style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Spacer(),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: RichText(
                  text: TextSpan(
                    text: "Powered by ",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                    children: [
                      TextSpan(
                        text: "NSD CORPORATION",
                        style: TextStyle(fontSize: 16, color: Color.fromRGBO(71, 38, 188, 0.75)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
