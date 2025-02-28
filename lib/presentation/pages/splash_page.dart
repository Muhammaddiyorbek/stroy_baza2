import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stroy_baza/presentation/blocs/splash/splash_bloc.dart';
import 'package:stroy_baza/presentation/blocs/splash/splash_event.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SplashBloc splashBloc;

  @override
  void initState() {
    super.initState();
    splashBloc = context.read<SplashBloc>();
    splashBloc.add(SplashWaitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Color.fromRGBO(220, 195, 139, 1),
        child: Image.asset(
          "assets/images/app_logo.png",
          height: double.infinity,
        ),
      ),
    );
  }
}
