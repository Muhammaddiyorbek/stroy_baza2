import 'package:flutter/material.dart';

class BoxPage extends StatefulWidget {
  const BoxPage({super.key});

  @override
  State<BoxPage> createState() => _BoxPageState();
}

class _BoxPageState extends State<BoxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
      ),
    );
  }
}
