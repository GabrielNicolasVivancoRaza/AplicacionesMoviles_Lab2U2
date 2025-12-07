import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/presentation/viewmodels/post_viewmodel.dart';
import 'src/domain/usecases/get_posts_usecase.dart';
import 'src/domain/usecases/get_post_by_id_usecase.dart';
import 'src/data/repositories/post_repository_impl.dart';
import 'src/data/datasources/post_api_datasource.dart';

import 'src/presentation/routes/app_routes.dart';
import 'src/presentation/themes/indice.dart';

void main() {
  // Inyección de dependencias
  final dataSource = PokemonApiDataSource();
  final repo = PokemonRepositoryImpl(dataSource);
  
  // Casos de uso
  final getPokemonsUseCase = GetPokemonsUseCase(repo);
  final getPokemonByIdUseCase = GetPokemonByIdUseCase(repo);

  runApp(MyApp(
    getPokemonsUseCase: getPokemonsUseCase,
    getPokemonByIdUseCase: getPokemonByIdUseCase,
  ));
}

class MyApp extends StatelessWidget {
  final GetPokemonsUseCase getPokemonsUseCase;
  final GetPokemonByIdUseCase getPokemonByIdUseCase;

  const MyApp({
    super.key,
    required this.getPokemonsUseCase,
    required this.getPokemonByIdUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PokemonViewModel(
            getPokemonsUseCase: getPokemonsUseCase,
            getPokemonByIdUseCase: getPokemonByIdUseCase,
          )..cargarPokemons(),
        ),
      ],
      child: MaterialApp(
        title: "Pokédex - Consumo API",
        initialRoute: "/",
        routes: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
        theme: temaGeneral,
      ),
    );
  }
}
