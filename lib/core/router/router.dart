import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/presentation/pages/Region1.dart';
import 'package:stroy_baza/presentation/pages/about_product.dart';
import 'package:stroy_baza/presentation/pages/aksiyalar_screen.dart';
import 'package:stroy_baza/presentation/pages/bottonNavBarPages/profile_page.dart';
import 'package:stroy_baza/presentation/pages/bottonNavBarPages/search_page.dart';
import 'package:stroy_baza/presentation/pages/cart_screen.dart';
import 'package:stroy_baza/presentation/pages/delivery_address_screen.dart';
import 'package:stroy_baza/presentation/pages/favorites_screen.dart';
import 'package:stroy_baza/presentation/pages/home.dart';
import 'package:stroy_baza/presentation/pages/bottonNavBarPages/home_page.dart';
import 'package:stroy_baza/presentation/pages/home_product.dart';
import 'package:stroy_baza/presentation/pages/init.dart';
import 'package:stroy_baza/presentation/pages/init2.dart';
import 'package:stroy_baza/presentation/pages/orders_screen.dart';
import 'package:stroy_baza/presentation/pages/payment_screen.dart';
import 'package:stroy_baza/presentation/pages/phone_input.dart';
import 'package:stroy_baza/presentation/pages/region2.dart';
import 'package:stroy_baza/presentation/pages/select_city.dart';
import 'package:stroy_baza/presentation/pages/select_lang.dart';
import 'package:stroy_baza/presentation/pages/user_agreement_screen.dart';

// Global navigator keys
final GlobalKey<NavigatorState> _appNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "app-key");
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "shell-key");

class AppRouteName {
  const AppRouteName._();

  static const String init = "/init";
  static const String init2 = "/init2";
  static const String region1 = "/region1";
  static const String region2 = "/region2";
  static const String subHome = "/subHome";
  static const String signUp = "/signUp";
  static const String homeProduct = "/homeProduct";
  static const String aboutProduct = "/aboutProduct";
  static const String sevimlilar = "/sevimlilar";
  static const String buyurtmalar = "/buyurtmalar";
  static const String aksiyalar = "/aksiyalar";
  static const String savatcha = "/savatcha";
  static const String home_buyurtma = "/home_buyurtma";
  static const String yetkazib_berish_manzili = "/yetkazib_berish_manzili";
  static const String shartnoma = "/shartnoma";
  static const String select_city = "/select_city";
  static const String select_lang = "/select_lang";

  /// Bottom nav bar pages
  static const String main = "/main-screen";
  static const String search = "/search";
  static const String box = "/box";
  static const String basket = "/basket";
  static const String profile = "/profile";
}

sealed class AppRouter {
  AppRouter._();

  static GoRouter router = GoRouter(
    navigatorKey: _appNavigatorKey,
    initialLocation: AppRouteName.init,
    routes: [
    // Kirish
    GoRoute(
    path: AppRouteName.init,
    pageBuilder: (context, state) => const CustomTransitionPage(
      child: Init(),
      transitionsBuilder: _fadeTransition,
    ),
  ),

  // Region1
      GoRoute(
  path: AppRouteName.region1,
  pageBuilder: (context, state) => const CustomTransitionPage(
  child: Region1(),
  transitionsBuilder: _fadeTransition,
  ),
  ),

  // Region2
  GoRoute(
  path: AppRouteName.region2,
  pageBuilder: (context, state) => const CustomTransitionPage(
  child: Region2(),
  transitionsBuilder: _fadeTransition,
  ),
  ),

  // Kirish2
  GoRoute(
  path: AppRouteName.init2,
  pageBuilder: (context, state) => const CustomTransitionPage(
  child: Init2(),
  transitionsBuilder: _fadeTransition,
  ),
  ),


  // SignUp
  GoRoute(
  path: AppRouteName.signUp,
  pageBuilder: (context, state) => const CustomTransitionPage(
  child: PhoneInputScreen(),
  transitionsBuilder: _fadeTransition,
  ),
  ),

  // Home Product
  GoRoute(
  path: "/homeProduct/:category",
  pageBuilder: (context, state) {
  final category = state.pathParameters['category'] ?? "Noma’lum";
  return CustomTransitionPage(
  child: HomeProduct(category: category),
  transitionsBuilder: _fadeTransition,
  );
  },
  ),

  // About Product
  GoRoute(
  path: AppRouteName.aboutProduct,
  pageBuilder: (context, state) => const CustomTransitionPage(
  child: AboutProduct(),
  transitionsBuilder: _fadeTransition,
  ),
  ),

  // Sevimlilar
  GoRoute(
  path: "/homeProduct/:category",
  pageBuilder: (context, state) {
  final category = state.pathParameters['category'] ?? "Noma’lum";
  return CustomTransitionPage(
  child: FavoritesScreen(category: category),
  transitionsBuilder: _fadeTransition,
  );
  },
  ),

  // Buyurtmalar
  GoRoute(
  path: AppRouteName.buyurtmalar,
  pageBuilder: (context, state) => const CustomTransitionPage(
  child: OrdersScreen(),
  transitionsBuilder: _fadeTransition,
  ),
  ),

  // Aksiyalar
  GoRoute(
  path: AppRouteName.aksiyalar,
  pageBuilder: (context, state) => const CustomTransitionPage(
  child: AksiyalarScreen(),
  transitionsBuilder: _fadeTransition,
  ),
  ),

  // Savatcha
  GoRoute(
  path: AppRouteName.savatcha,
  pageBuilder: (context, state) => const CustomTransitionPage(
  child: CartScreen(),
  transitionsBuilder: _fadeTransition,
  ),
  ),

  // home_buyurtma
  GoRoute(
  path: AppRouteName.home_buyurtma,
  pageBuilder: (context, state) => const CustomTransitionPage(
  child: PaymentScreen(),
  transitionsBuilder: _fadeTransition,
  ),
  ),

  // yetkazib_berish_manzili
  GoRoute(
  path: AppRouteName.yetkazib_berish_manzili,
  pageBuilder: (context, state) => const CustomTransitionPage(
  child: DeliveryAddressScreen(),
  transitionsBuilder: _fadeTransition,
  ),
  ),

  // shartnoma
  GoRoute(
  path: AppRouteName.shartnoma,
  pageBuilder: (context, state) => const CustomTransitionPage(
  child: UserAgreementScreen(),
  transitionsBuilder: _fadeTransition,
  ),
  ),

  //  select_city
  GoRoute(
  path: AppRouteName.select_city,
  pageBuilder: (context, state) => const CustomTransitionPage(
  child: SelectCity(),
  transitionsBuilder: _fadeTransition,
  ),
  ),

  // select_lang
  GoRoute(
  path: AppRouteName.select_lang,
  pageBuilder: (context, state) => const CustomTransitionPage(
  child: SelectLang(),
  transitionsBuilder: _fadeTransition,
  ),
  ),

      // Stateful Shell Route for bottom navigation pages
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _appNavigatorKey,
        builder: (context, state, navigationShell) {
          return MainWrapper(navigationShell: navigationShell);
        },
        branches: [
          // Home branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorKey,
            routes: [
              GoRoute(
                path: AppRouteName.main,
                pageBuilder: (context, state) => const CustomTransitionPage(
                  child: HomePage(),
                  transitionsBuilder: _fadeTransition,
                  transitionDuration: Duration(seconds: 2),
                ),
              ),
            ],
          ),
          // Search branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouteName.search,
                pageBuilder: (context, state) => const CustomTransitionPage(
                  child: SearchPage(),
                  transitionsBuilder: _fadeTransition,
                  transitionDuration: Duration(seconds: 2),
                ),
              ),
            ],
          ),
          // Box branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouteName.box,
                pageBuilder: (context, state) => const CustomTransitionPage(
                  child: Scaffold(body: Center(child: Text("Box"))),
                  transitionsBuilder: _fadeTransition,
                  transitionDuration: Duration(seconds: 2),
                ),
              ),
            ],
          ),
          // Basket branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouteName.basket,
                pageBuilder: (context, state) => const CustomTransitionPage(
                  child: CartScreen(),
                  transitionsBuilder: _fadeTransition,
                  transitionDuration: Duration(seconds: 2),
                ),
              ),
            ],
          ),
          // Profile branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouteName.profile,
                pageBuilder: (context, state) => const CustomTransitionPage(
                  child: ProfilePage(),
                  transitionsBuilder: _fadeTransition,
                  transitionDuration: Duration(seconds: 2),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  static Widget _fadeTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
