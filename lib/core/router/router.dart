import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/models/product.dart';
import 'package:stroy_baza/presentation/pages/Region1.dart';
import 'package:stroy_baza/presentation/search/pages/about_product.dart';
import 'package:stroy_baza/presentation/profile/pages/profile_page.dart';
import 'package:stroy_baza/presentation/search/pages/search_page.dart';
import 'package:stroy_baza/presentation/basked/pages/cart_screen.dart';
import 'package:stroy_baza/presentation/pages/home.dart';
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

  static const String init = "/init";
  static const String init2 = "/init2";
  static const String region1 = "/region1";
  static const String region2 = "/region2";
  static const String subHome = "subHome";
  static const String signUp = "signUp";
  static const String homeProduct = "homeProduct";
  static const String aboutProduct = "aboutProduct";

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
          child: CitySelectionPage(),
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
                      return CustomTransitionPage(
                        child: AboutProduct(product: state.extra as Product),
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
