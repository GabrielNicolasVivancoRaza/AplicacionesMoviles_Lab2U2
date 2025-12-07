import '../../domain/entities/post_entity.dart';
import '../datasources/base_datasource.dart';
import 'base_repository.dart';

class PokemonRepositoryImpl implements BaseRepository {
  final BaseDataSource ds;

  PokemonRepositoryImpl(this.ds);

  @override
  Future<List<PokemonEntity>> getPokemons({int offset = 0, int limit = 20}) {
    return ds.fetchPokemons(offset: offset, limit: limit);
  }

  @override
  Future<PokemonEntity> getPokemonById(int id) {
    return ds.getPokemon(id);
  }
}
