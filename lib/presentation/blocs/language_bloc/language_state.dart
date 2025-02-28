part of 'language_bloc.dart';

class LanguageState extends Equatable {
  final FormzSubmissionStatus languageStatus;
  final String langCode;
  final Locale locale;

  const LanguageState({
    this.langCode = "",
    this.locale = const Locale("uz", "Uz"),
    this.languageStatus = FormzSubmissionStatus.initial,
  });

  LanguageState copyWith({
    FormzSubmissionStatus? languageStatus,
    String? langCode,
    Locale? locale,
  }) =>
      LanguageState(
        locale: locale ?? this.locale,
        langCode: langCode ?? this.langCode,
        languageStatus: languageStatus ?? this.languageStatus,
      );

  @override
  List<Object?> get props => [languageStatus, langCode, locale];
}
