import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/core/extensions/context_extension.dart';
import 'package:stroy_baza/core/router/router.dart';
import 'package:stroy_baza/presentation/blocs/city/city_bloc.dart';
import 'package:stroy_baza/presentation/blocs/city/city_event.dart';
import 'package:stroy_baza/presentation/blocs/city/city_state.dart';

class Region1 extends StatelessWidget {
  const Region1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CityBloc, CityState>(
        builder: (context, state) {
          String selectedCityName = state.selectedCity?.nameUz.replaceAll(" shahar", "") ?? "Farg'ona";

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // RASM
                Image.asset(
                  "assets/images/region_logo.png",
                  height: 100,
                ),
                const SizedBox(height: 24),

                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "${context.localized.you} ",
                        style: const TextStyle(fontSize: 18),
                      ),
                      TextSpan(
                        text: selectedCityName,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "${context.localized.city} ",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                Text(
                  context.localized.detectProductAndDelivery,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color.fromRGBO(13, 18, 24, 1),
                  ),
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButton(
                      context.localized.nochange,
                      const Color.fromRGBO(228, 228, 225, 1),
                      Colors.black,
                      onTap: () {
                        context.read<CityBloc>().add(LoadCities());
                        context.push(AppRouteName.region2);
                      },
                    ),
                    const SizedBox(width: 12),
                    _buildButton(
                      context.localized.yes,
                      const Color.fromRGBO(220, 195, 139, 1),
                      Colors.white,
                      onTap: () {
                        context.push(AppRouteName.init2);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildButton(
    String text,
    Color bgColor,
    Color textColor, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        width: 133,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
