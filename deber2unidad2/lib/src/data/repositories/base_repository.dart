import '../../domain/entities/post_entity.dart';

abstract class BaseRepository {
  Future<List<PokemonEntity>> getPokemons({int offset = 0, int limit = 20});
  Future<PokemonEntity> getPokemonById(int id);
}
