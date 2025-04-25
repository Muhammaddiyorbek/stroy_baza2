import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/core/router/router.dart';
import 'package:stroy_baza/core/services/local_storage_helper.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool checkUser() {
    final lang = StorageRepository.getString(StorageKeys.language, defValue: "xcnma");
    final location = StorageRepository.getString(StorageKeys.location);
    log("lang: $lang ==== location: $location");

    if (lang.isEmpty && location.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void didChangeDependencies() async {
    Future.delayed(const Duration(seconds: 2), () {
      if (checkUser()) {
        context.go(AppRouteName.init);
      } else {
        context.go(AppRouteName.main);
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 212,
          height: 186,
          child: Image.asset("assets/images/splash.png"),
        ),
      ),
    );
  }
}
