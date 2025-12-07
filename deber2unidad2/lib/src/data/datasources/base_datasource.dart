import '../models/post_model.dart';

abstract class BaseDataSource {
  Future<List<PokemonModel>> fetchPokemons({int offset = 0, int limit = 20});
  Future<PokemonModel> getPokemon(int id);
}
