import 'package:flutter/material.dart';
import 'package:stroy_baza/main.dart';

extension CustomContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get screenSize => mediaQuery.size;

  ThemeData get theme => Theme.of(this);

  ColorScheme get appTheme => Theme.of(this).colorScheme;

  // AppTextStyle get appTextStyle => AppTextStyle(this);
  AppLocalizations get localized => AppLocalizations.of(this)!;
}
