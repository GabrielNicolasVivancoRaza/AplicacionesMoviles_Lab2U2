import '../entities/post_entity.dart';
import '../../data/repositories/base_repository.dart';

class GetPokemonByIdUseCase {
  final BaseRepository repository;

  GetPokemonByIdUseCase(this.repository);

  Future<PokemonEntity> call(int id) {
    return repository.getPokemonById(id);
  }
}
