import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart'; // Descomenta cuando agregues archivos .json

/// Widget opcional para mostrar animaciones Lottie
/// Para usar este widget:
/// 1. Descarga una animación .json de https://lottiefiles.com/
/// 2. Guárdala en assets/animations/
/// 3. Descomenta el código en esta clase
/// 4. Úsalo en lugar de CircularProgressIndicator

class LottieLoadingWidget extends StatelessWidget {
  const LottieLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Descomenta las siguientes líneas después de agregar un archivo .json:
          // Lottie.asset(
          //   'assets/animations/loading.json',  // Cambia por el nombre de tu archivo
          //   width: 200,
          //   height: 200,
          //   fit: BoxFit.contain,
          // ),
          // const SizedBox(height: 16),
          // const Text(
          //   'Cargando Pokémon...',
          //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          // ),
          
          // Mientras tanto, usa esto:
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          const Text(
            'Cargando Pokémon...',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

/// Ejemplo de uso en tus vistas:
/// 
/// En lugar de:
/// if (vm.loading) {
///   return const Center(child: CircularProgressIndicator());
/// }
///
/// Usa:
/// if (vm.loading) {
///   return const LottieLoadingWidget();
/// }

/// Animaciones recomendadas de LottieFiles:
/// - Pokébola girando
/// - Pikachu corriendo
/// - Loading con tema Pokémon
/// - Spinner personalizado
