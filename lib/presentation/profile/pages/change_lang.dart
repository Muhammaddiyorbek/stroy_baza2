import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/core/router/router.dart';
import 'package:stroy_baza/presentation/blocs/language_bloc/language_bloc.dart';

class ChangeLang extends StatefulWidget {
  const ChangeLang({super.key});

  @override
  State<ChangeLang> createState() => _ChangeLangState();
}

class _ChangeLangState extends State<ChangeLang> {
  List<Map<String, String>> languages = [
    {"title": "O'zbekcha", "langCode": LocaleCodeEnum.uz.name},
    {"title": "Ўзбекча", "langCode": LocaleCodeEnum.kk.name},
    {"title": "Русский", "langCode": LocaleCodeEnum.ru.name},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(220, 195, 139, 1),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: -15,
        title: const Text(
          "Til tanlash",
          style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ...List.generate(
          languages.length,
          (index) {
            final item = languages[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: GestureDetector(
                onTap: () {
                  context.read<LanguageBloc>().add(ChangeLocaleEvent(langCode: item["langCode"]!));
                  context.pop();
                },
                child: Container(
                  height: 60,
                  margin: const EdgeInsets.only(left: 42, right: 42),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromRGBO(220, 195, 139, 1), width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(child: Text(item["title"]!, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500))),
                ),
              ),
            );
          },
        ),
      ]),
    );
  }
}
