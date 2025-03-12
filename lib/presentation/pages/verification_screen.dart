import 'package:flutter/material.dart';
import 'dart:async';

import 'package:stroy_baza/presentation/pages/fullname_screen.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
  static const routeName = '/verification-screen';
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> controllers =
      List.generate(5, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(5, (_) => FocusNode());
  Timer? _timer;
  int _timeLeft = 59;

  @override
  void initState() {
    super.initState();
    startTimer();

    // Add listeners to all text fields
    for (int i = 0; i < 5; i++) {
      controllers[i].addListener(() {
        if (controllers[i].text.length == 1 && i < 4) {
          focusNodes[i + 1].requestFocus();
        }
      });
    }
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft == 0) {
        timer.cancel();
      } else {
        setState(() {
          _timeLeft--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phoneNumber = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100),
              Text(
                'Biz quyidagi telefon raqamiga sms yubordik :\n$phoneNumber',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(213, 213, 213, 0.55),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                          cursorHeight: 40,
                          controller: controllers[index],
                          focusNode: focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.grey[300]!,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.grey[300]!,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.yellow,
                                width: 2,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.length == 1 && index < 4) {
                              focusNodes[index + 1].requestFocus();
                            }
                            if (value.isEmpty && index > 0) {
                              focusNodes[index - 1].requestFocus();
                            }
                          },
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),
              Text(
                'Kodni qayta yuborish 00:${_timeLeft.toString().padLeft(2, '0')}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 223, 2, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(color: Colors.grey, width: 0.5)),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationScreen()));
                  },
                  child: Text(
                    'Kirish',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Telefon raqamni o'zgartirish",
                    style: TextStyle(
                        fontSize: 16, color: Color.fromRGBO(71, 38, 188, 0.75)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
