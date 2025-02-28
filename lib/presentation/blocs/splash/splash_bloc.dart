import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stroy_baza/presentation/blocs/home/home_bloc.dart';
import 'package:stroy_baza/presentation/blocs/splash/splash_event.dart';
import 'package:stroy_baza/presentation/blocs/splash/splash_state.dart';
import 'package:stroy_baza/presentation/pages/bottonNavBarPages/home_page.dart';
import 'package:stroy_baza/presentation/pages/init.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    on<SplashWaitEvent>(_onSplashWaitEvent);
  }

  Future<void> _onSplashWaitEvent(SplashWaitEvent event, Emitter<SplashState> emit) async {
    emit(SplashLoadingState());
    await Future.delayed(Duration(seconds: 2));
    emit(SplashLoadedState());
  }

// callNextPage(BuildContext context) {
//   if (AuthService.isLoggedIn()) {
//     Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//             builder: (context) => BlocProvider(
//                   create: (context) => HomeBloc(),
//                   child: HomePage(),
//                 )));
//   } else {
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
//       return BlocProvider(
//         create: (context) => InitBloc(),
//         child: Init(),
//       );
//     }));
//   }
// }
}
