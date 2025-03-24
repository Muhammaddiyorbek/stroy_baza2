import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/presentation/home/blocs/home/home_bloc.dart';
import 'package:stroy_baza/presentation/home/blocs/home/home_state.dart';

class MainWrapper extends StatelessWidget {
  const MainWrapper({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onItemTapped(int i) => navigationShell.goBranch(i, initialLocation: i == navigationShell.currentIndex);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: CupertinoTabBar(
            height: 75,
            backgroundColor: const Color.fromRGBO(190, 160, 134, 1),
            onTap: _onItemTapped,
            currentIndex: navigationShell.currentIndex,
            inactiveColor: const Color.fromRGBO(255, 255, 255, 0.5),
            activeColor: const Color.fromRGBO(255, 255, 255, 1),
            items: [
              BottomNavigationBarItem(
                icon: Builder(
                  builder: (context) {
                    final iconColor = IconTheme.of(context).color;
                    return SvgPicture.asset(
                      "assets/icons/home_bottom.svg",
                      height: 26,
                      color: iconColor,
                    );
                  },
                ),
              ),
              BottomNavigationBarItem(
                icon: Builder(
                  builder: (context) {
                    final iconColor = IconTheme.of(context).color;
                    return SvgPicture.asset(
                      "assets/icons/search_bottom.svg",
                      height: 26,
                      color: iconColor,
                    );
                  },
                ),
              ),
              BottomNavigationBarItem(
                icon: Builder(
                  builder: (context) {
                    final iconColor = IconTheme.of(context).color;
                    return SvgPicture.asset(
                      "assets/icons/box_bottom.svg",
                      height: 26,
                      color: iconColor,
                    );
                  },
                ),
              ),
              BottomNavigationBarItem(
                icon: Builder(
                  builder: (context) {
                    final iconColor = IconTheme.of(context).color;
                    return SvgPicture.asset(
                      "assets/icons/basked_bottom.svg",
                      height: 26,
                      color: iconColor,
                    );
                  },
                ),
              ),
              BottomNavigationBarItem(
                icon: Builder(
                  builder: (context) {
                    final iconColor = IconTheme.of(context).color;
                    return SvgPicture.asset(
                      "assets/icons/profile_bottom.svg",
                      height: 26,
                      color: iconColor,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
