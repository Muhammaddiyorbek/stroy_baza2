import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/core/services/local_storage_helper.dart';
import 'package:stroy_baza/models/product.dart';
import 'package:stroy_baza/presentation/pages/Region1.dart';
import 'package:stroy_baza/presentation/pages/main_wrapper.dart';
import 'package:stroy_baza/presentation/pages/splash.dart';
import 'package:stroy_baza/presentation/profile/pages/change_city.dart';
import 'package:stroy_baza/presentation/profile/pages/change_lang.dart';
import 'package:stroy_baza/presentation/home/widgets/about_product.dart';
import 'package:stroy_baza/presentation/profile/pages/profile_page.dart';
import 'package:stroy_baza/presentation/search/pages/search_page.dart';
import 'package:stroy_baza/presentation/basked/pages/cart_screen.dart';
import 'package:stroy_baza/presentation/home/pages/home_page.dart';
import 'package:stroy_baza/presentation/search/pages/home_product.dart';
import 'package:stroy_baza/presentation/pages/init.dart';
import 'package:stroy_baza/presentation/pages/init2.dart';
import 'package:stroy_baza/presentation/pages/region2.dart';

// Global navigator keys
final GlobalKey<NavigatorState> _appNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "app-key");
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "shell-key");

class AppRouteName {
  const AppRouteName._();

  static const String splash = "/splash";
  static const String init = "/init";
  static const String init2 = "/init2";
  static const String region1 = "/region1";
  static const String region2 = "/region2";
  static const String subHome = "subHome";
  static const String signUp = "signUp";
  static const String homeProduct = "homeProduct";
  static const String aboutProduct = "aboutProduct";
  static const String changeLanguage = "changeLanguage";
  static const String changeLocation = "changeLocation";

  /// Bottom nav bar pages
  static const String main = "/main-screen";
  static const String search = "/search";
  static const String box = "/box";
  static const String basket = "/basket";
  static const String profile = "/profile";
}

sealed class AppRouter {
  AppRouter._();

  final lang = StorageRepository.getString("app_local", defValue: '');
  final location = StorageRepository.getString("location");

  String path() {
    if (lang.isEmpty && location.isEmpty) {
      return AppRouteName.init;
    } else {
      return AppRouteName.init2;
    }
  }

  static GoRouter router = GoRouter(
    navigatorKey: _appNavigatorKey,
    initialLocation: AppRouteName.splash,
    routes: [
      // Splash
      GoRoute(
        path: AppRouteName.splash,
        pageBuilder: (context, state) => const CustomTransitionPage(
          child: Splash(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
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
          child: CitySelectionPage(),
          transitionsBuilder: _fadeTransition,
        ),
      ),

      // changeLanguage
      GoRoute(
        path: AppRouteName.changeLanguage,
        pageBuilder: (context, state) => const CustomTransitionPage(
          child: ChangeLang(),
          transitionsBuilder: _fadeTransition,
        ),
      ),

      // changeLocation
      GoRoute(
        path: AppRouteName.changeLocation,
        pageBuilder: (context, state) => const CustomTransitionPage(
          child: ChangeCity(),
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
          child: ProfilePage(),
          transitionsBuilder: _fadeTransition,
        ),
      ),

      // Stateful Shell Route for bottom navigation pages
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _appNavigatorKey,
        builder: (context, state, navigationShell) => MainWrapper(navigationShell: navigationShell),
        branches: [
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
                routes: [
                  GoRoute(
                    parentNavigatorKey: _appNavigatorKey,
                    path: AppRouteName.aboutProduct,
                    pageBuilder: (context, state) {
                      final productMap = state.extra as Map<String, dynamic>; // Map qilib oladi
                      final product = Product.fromJson(productMap); // keyin Product obyektga o'giradi
                      return CustomTransitionPage(
                        child: AboutProduct(product: product),
                        transitionsBuilder: _fadeTransition,
                      );
                    },
                  ),
                ],
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
                  routes: [
                    GoRoute(
                      parentNavigatorKey: _appNavigatorKey,
                      path: AppRouteName.homeProduct,
                      pageBuilder: (context, state) {
                        //final id = state.pathParameters['id'] ?? '';
                        return const CustomTransitionPage(
                          child: HomeProduct(),
                          transitionsBuilder: _fadeTransition,
                        );
                      },
                    ),
                  ]),
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
                routes: [
                  GoRoute(
                    parentNavigatorKey: _appNavigatorKey,
                    path: AppRouteName.changeLanguage,
                    pageBuilder: (context, state) {
                      return const CustomTransitionPage(
                        child: ChangeLang(),
                        transitionsBuilder: _fadeTransition,
                      );
                    },
                  ),
                ],
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
