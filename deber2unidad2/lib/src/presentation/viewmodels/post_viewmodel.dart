import '../../domain/entities/post_entity.dart';
import '../../domain/usecases/get_posts_usecase.dart';
import '../../domain/usecases/get_post_by_id_usecase.dart';
import 'base_viewmodel.dart';

class PokemonViewModel extends BaseViewModel {
  final GetPokemonsUseCase getPokemonsUseCase;
  final GetPokemonByIdUseCase getPokemonByIdUseCase;

  List<PokemonEntity> pokemons = [];
  PokemonEntity? selectedPokemon;
  String? errorMessage;
  
  // Para infinite scroll
  int _currentOffset = 0;
  final int _limit = 20;
  bool _isLoadingMore = false;
  bool _hasMore = true;

  PokemonViewModel({
    required this.getPokemonsUseCase,
    required this.getPokemonByIdUseCase,
  });

  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _hasMore;

  Future<void> cargarPokemons() async {
    setLoading(true);
    errorMessage = null;
    _currentOffset = 0;
    _hasMore = true;
    try {
      pokemons = await getPokemonsUseCase(offset: 0, limit: _limit);
      _currentOffset = _limit;
    } catch (e) {
      errorMessage = 'Error al cargar pokémon: $e';
      pokemons = [];
    }
    setLoading(false);
  }

  Future<void> cargarMasPokemons() async {
    if (_isLoadingMore || !_hasMore) return;
    
    _isLoadingMore = true;
    notifyListeners();
    
    try {
      final nuevosPokemon = await getPokemonsUseCase(
        offset: _currentOffset,
        limit: _limit,
      );
      
      if (nuevosPokemon.isEmpty) {
        _hasMore = false;
      } else {
        pokemons.addAll(nuevosPokemon);
        _currentOffset += _limit;
      }
    } catch (e) {
      errorMessage = 'Error al cargar más pokémon: $e';
    }
    
    _isLoadingMore = false;
    notifyListeners();
  }

  Future<void> cargarPokemonPorId(int id) async {
    setLoading(true);
    errorMessage = null;
    try {
      selectedPokemon = await getPokemonByIdUseCase(id);
    } catch (e) {
      errorMessage = 'Error al cargar pokémon: $e';
      selectedPokemon = null;
    }
    setLoading(false);
  }
}
