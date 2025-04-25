import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:stroy_baza/core/services/local_storage_helper.dart';

part 'language_event.dart';

part 'language_state.dart';

enum LocaleCodeEnum { uz, ru, kk } //"uz", "ru", "kk"

// String name = LocaleCode.uz.name;

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState()) {
    on<FindCurrentLanguageEvent>(_onFindCurrentLanguageEvent);
    on<ChangeLocaleEvent>(_onChangeLocaleEvent);

    log("languageeee: ${StorageRepository.getString(StorageKeys.language)}");
  }

  FutureOr<void> _onFindCurrentLanguageEvent(
    FindCurrentLanguageEvent event,
    Emitter<LanguageState> emit,
  ) async {
    emit(state.copyWith(languageStatus: FormzSubmissionStatus.inProgress));

    final savedLangCode = await StorageRepository.getString(StorageKeys.language, defValue: '');
    log("Saved langyuage in locale $savedLangCode");

    if (savedLangCode.isNotEmpty) {
      log("Saved langyuage in locale  is not empty");
      final newLocale = _getLocaleFromCode(savedLangCode);
      emit(
        state.copyWith(
          langCode: savedLangCode,
          locale: newLocale,
          languageStatus: FormzSubmissionStatus.success,
        ),
      );
    } else {
      log("Saved langyuage in locale  is empty");
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

    // Tilni xotiraga saqlaymiz
    await StorageRepository.putString(StorageKeys.language, event.langCode);
    final lang = StorageRepository.getString(StorageKeys.language, defValue: "xcnma");

    log("saved language: $lang");

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
