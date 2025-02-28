import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_event.dart';

part 'language_state.dart';

enum LocaleCodeEnum { uz, ru, kk } //"uz", "ru", "kk"

// String name = LocaleCode.uz.name;

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  static const String _spLocalKey = "app_local";

  LanguageBloc() : super(const LanguageState()) {
    on<FindCurrentLanguageEvent>(_onFindCurrentLanguageEvent);
    on<ChangeLocaleEvent>(_onChangeLocaleEvent);
  }

  FutureOr<void> _onFindCurrentLanguageEvent(
    FindCurrentLanguageEvent event,
    Emitter<LanguageState> emit,
  ) async {
    emit(state.copyWith(languageStatus: FormzSubmissionStatus.inProgress));

    final sp = await SharedPreferences.getInstance();
    final savedLangCode = sp.getString(_spLocalKey);

    if (savedLangCode != null && savedLangCode.isNotEmpty) {
      final newLocale = _getLocaleFromCode(savedLangCode);
      emit(
        state.copyWith(
          langCode: savedLangCode,
          locale: newLocale,
          languageStatus: FormzSubmissionStatus.success,
        ),
      );
    } else {
      // Agar saqlangan til bo'lmasa, default "uz"
      emit(
        state.copyWith(
          langCode: "uz",
          locale: const Locale("uz", "UZ"),
          languageStatus: FormzSubmissionStatus.success,
        ),
      );
    }
  }

  FutureOr<void> _onChangeLocaleEvent(
    ChangeLocaleEvent event,
    Emitter<LanguageState> emit,
  ) async {
    emit(state.copyWith(languageStatus: FormzSubmissionStatus.inProgress));

    final newLocale = _getLocaleFromCode(event.langCode);
    final sp = await SharedPreferences.getInstance();

    // Tilni xotiraga saqlaymiz
    await sp.setString(_spLocalKey, event.langCode);
    log("Locale saved to SharedPreferences: ${event.langCode}");

    // State ga emit qilamiz
    emit(
      state.copyWith(
        langCode: event.langCode,
        locale: newLocale,
        languageStatus: FormzSubmissionStatus.success,
      ),
    );
    log("Locale changed to: ${event.langCode}");
  }

  // Helper: langCode -> Locale
  Locale _getLocaleFromCode(String code) {
    switch (code) {
      case "ru":
        return const Locale("ru", "RU");
      case "kk":
        return const Locale("kk", "KK");
      case "uz":
      default:
        return const Locale("uz", "UZ");
    }
  }
}
