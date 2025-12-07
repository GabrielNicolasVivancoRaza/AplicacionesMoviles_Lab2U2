// Tests básicos para la aplicación Pokédex

import 'package:flutter_test/flutter_test.dart';
import 'package:deber2unidad2/src/data/datasources/post_api_datasource.dart';
import 'package:deber2unidad2/src/data/repositories/post_repository_impl.dart';
import 'package:deber2unidad2/src/domain/usecases/get_posts_usecase.dart';

void main() {
  group('Pokémon API Tests', () {
    test('DataSource debe ser instanciable', () {
      final dataSource = PokemonApiDataSource();
      expect(dataSource, isNotNull);
    });

    test('Repository debe ser instanciable', () {
      final dataSource = PokemonApiDataSource();
      final repository = PokemonRepositoryImpl(dataSource);
      expect(repository, isNotNull);
    });

    test('UseCase debe ser instanciable', () {
      final dataSource = PokemonApiDataSource();
      final repository = PokemonRepositoryImpl(dataSource);
      final useCase = GetPokemonsUseCase(repository);
      expect(useCase, isNotNull);
    });
  });
}
