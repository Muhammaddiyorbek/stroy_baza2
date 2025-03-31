import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/core/router/router.dart';
import 'package:stroy_baza/core/utils/enums.dart';
import 'package:stroy_baza/logic/bloc/product_bloc.dart';
import 'package:stroy_baza/logic/bloc/product_event.dart';

class Init2 extends StatefulWidget {
  const Init2({super.key});

  @override
  State<Init2> createState() => _Init2State();
}

class _Init2State extends State<Init2> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              SectionEnum.values.length,
                  (index) {
                final section = SectionEnum.values[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 31.0, vertical: 10),
                  child: MaterialButton(
                    onPressed: () {
                      ///Bloc func, save event, item.name => state save
                      context.read<ProductBloc>().add(SaveSectionEvent(section: section));
                      context.go(AppRouteName.main);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: const BorderSide(
                        color: Color.fromRGBO(220, 195, 139, 1),
                        width: 1.5,
                      ),
                    ),
                    height: 60,
                    child: Row(
                      children: [
                        const SizedBox(width: 30),
                        Image.asset(section.icon),
                        const SizedBox(width: 31),
                        Text(
                          section.name,
                          style: const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
