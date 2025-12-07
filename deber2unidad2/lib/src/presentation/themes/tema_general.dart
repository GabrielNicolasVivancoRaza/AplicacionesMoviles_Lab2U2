import 'package:flutter/material.dart';
import 'tema_appbar.dart';

final temaGeneral = ThemeData(
  appBarTheme: appBarTema,
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFF8F9FC),
  cardTheme: const CardThemeData(
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  ),
);
