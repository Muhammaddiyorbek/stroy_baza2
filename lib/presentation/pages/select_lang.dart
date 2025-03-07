import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/core/router/router.dart';
import 'package:stroy_baza/presentation/blocs/language_bloc/language_bloc.dart';

class SelectLang extends StatefulWidget {
  const SelectLang({super.key});

  @override
  State<SelectLang> createState() => _SelectLangState();
}

class _SelectLangState extends State<SelectLang> {
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
          onPressed: () => context.go(AppRouteName.profile),
        ),
        title: const Text(
          "Til tanlash",
          style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42),
            child: Column(
              children: [
                ...List.generate(
                  languages.length,
                      (index) {
                    final item = languages[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: GestureDetector(
                        onTap: () {
                          context.read<LanguageBloc>().add(ChangeLocaleEvent(langCode: item["langCode"]!));
                        },
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color.fromRGBO(220, 195, 139, 1), width: 1.5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              item["title"]!,
                              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(220, 195, 139, 1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      context.push(AppRouteName.savatcha);
                    },
                    child: const Text(
                      "O'zgartirish",
                      style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
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
