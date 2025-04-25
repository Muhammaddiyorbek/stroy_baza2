import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:stroy_baza/core/services/local_storage_helper.dart';
import 'package:stroy_baza/models/city_select.dart';
import 'package:stroy_baza/presentation/blocs/city/city_bloc.dart';
import 'package:stroy_baza/presentation/blocs/city/city_event.dart';
import 'package:stroy_baza/presentation/blocs/city/city_state.dart';

class ChangeCity extends StatelessWidget {
  const ChangeCity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: const Text(
            "Yetkazib berish shahrini tanlang",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(220, 195, 139, 1),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CityBloc, CityState>(
              builder: (context, state) {
                if (state.cityStatus == FormzSubmissionStatus.inProgress) {
                  return const Center(
                      child: CupertinoActivityIndicator(
                    color: Color.fromRGBO(220, 195, 139, 1),
                  ));
                } else if (state.cityStatus == FormzSubmissionStatus.success) {
                  return ListView.builder(
                    itemCount: state.cities.length,
                    itemBuilder: (context, index) {
                      City city = state.cities[index];

                      return Column(
                        children: [
                          SizedBox(
                            height: 45,
                          ),
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 22),
                              child: Text(city.nameUz),
                            ),
                            onTap: () {
                              StorageRepository.putString(StorageKeys.location, city.nameUz.replaceAll("shahri", ''));
                              context.read<CityBloc>().add(SelectCity(city));
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(height: 50),
                        ],
                      );
                    },
                  );
                } else if (state.cityStatus == FormzSubmissionStatus.failure) {
                  return Center(child: Text(state.errorMsg));
                } else {
                  return const Center(child: Text("Ma'lumot yo‘q"));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "Powered by",
                  style: TextStyle(
                    color: Color.fromRGBO(67, 67, 67, 0.81),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "NSD CORPORATION",
                    style: TextStyle(
                      color: Color.fromRGBO(130, 100, 242, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
