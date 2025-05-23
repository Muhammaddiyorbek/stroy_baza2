import 'package:device_preview/device_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stroy_baza/core/router/router.dart';
import 'package:stroy_baza/core/services/local_storage_helper.dart';
import 'package:stroy_baza/logic/bloc_auth/auth_bloc.dart';
import 'package:stroy_baza/logic/repository/auth_repository.dart';
import 'package:stroy_baza/logic/repository/city_responsitory.dart';
import 'package:stroy_baza/logic/repository/user_agreement_repository.dart';
import 'package:stroy_baza/presentation/basked/bolcs/user_agreement/user_agreement_bloc.dart';
import 'package:stroy_baza/presentation/blocs/city/city_bloc.dart';
import 'package:stroy_baza/presentation/blocs/language_bloc/language_bloc.dart';
import 'package:stroy_baza/logic/bloc/product_bloc.dart';
import 'package:stroy_baza/logic/repository/product_repository.dart';
import 'package:stroy_baza/presentation/home/blocs/home_bloc.dart';
import 'main.dart';
export "package:flutter_gen/gen_l10n/app_localizations.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LanguageBloc()..add(FindCurrentLanguageEvent())),
        BlocProvider(create: (context) => ProductBloc(ProductRepositoryImpl())),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => CityBloc(CityRepository())),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => UserAgreementBloc(UserAgreementRepository(Dio()))),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, languageState) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.router,
            title: 'Stroy baza',
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: languageState.locale,
            theme: LightTheme.light(),
          );
        },
      ),
    );
  }
}

abstract class LightTheme {
  static ThemeData light() => ThemeData(
          textTheme: const TextTheme(
        labelMedium: TextStyle(fontFamily: "Inter"),
        labelSmall: TextStyle(fontFamily: "Inter"),
        labelLarge: TextStyle(fontFamily: "Inter"),
      ));
}
