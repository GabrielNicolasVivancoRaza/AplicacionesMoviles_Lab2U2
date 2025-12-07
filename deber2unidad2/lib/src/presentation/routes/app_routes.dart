import 'package:flutter/material.dart';
import '../views/home_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String pokemonDetail = '/pokemon-detail';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomePage(),
    // La ruta de detalle se maneja con Navigator.push pasando el objeto pokemon
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // Aquí podrías manejar rutas dinámicas si lo necesitas
    return null;
  }
}
