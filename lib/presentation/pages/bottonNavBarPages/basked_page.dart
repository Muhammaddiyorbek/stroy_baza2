import 'package:flutter/material.dart';

class BaskedPage extends StatefulWidget {
  const BaskedPage({super.key});

  @override
  State<BaskedPage> createState() => _BaskedPageState();
}

class _BaskedPageState extends State<BaskedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
      ),
    );
  }
}
