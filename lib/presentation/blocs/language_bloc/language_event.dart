part of 'language_bloc.dart';

sealed class LanguageEvent extends Equatable {
  const LanguageEvent();
}

class FindCurrentLanguageEvent extends LanguageEvent {
  @override
  List<Object?> get props => [];
}

class ChangeLocaleEvent extends LanguageEvent {
  final String langCode;

  const ChangeLocaleEvent({required this.langCode});

  @override
  List<Object?> get props => [];
}
