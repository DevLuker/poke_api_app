import 'package:flutter/material.dart';
import 'package:poke_api_app/app/config/config.dart';

ThemeData buildTheme(BuildContext context) {
  final themeData = Theme.of(context);
  final colorScheme = ColorScheme.fromSwatch(primarySwatch: AppColors.red);

  final theme = themeData.copyWith(
    colorScheme: colorScheme,
  );

  return theme;
}
