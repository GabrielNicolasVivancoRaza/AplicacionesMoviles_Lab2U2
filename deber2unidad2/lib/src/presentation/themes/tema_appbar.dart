import 'package:flutter/material.dart';
import 'esquema_color.dart';

final appBarTema = AppBarTheme(
  backgroundColor: ColoresApp.primario,
  foregroundColor: Colors.white,
  centerTitle: true,
  elevation: 2,
  titleTextStyle: const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22,
    color: Colors.white,
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
);
