import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/post_viewmodel.dart';
import '../themes/indice.dart';
import '../widgets/pokemon_shimmer_loading.dart';
import 'pokemon_detail_page.dart';

class PokemonGridView extends StatefulWidget {
  const PokemonGridView({super.key});

  @override
  State<PokemonGridView> createState() => _PokemonGridViewState();
}

class _PokemonGridViewState extends State<PokemonGridView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      final vm = context.read<PokemonViewModel>();
      if (!vm.isLoadingMore && vm.hasMore) {
        vm.cargarMasPokemons();
      }
    }
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return ColoresApp.tipFuego;
      case 'water':
        return ColoresApp.tipAgua;
      case 'grass':
        return ColoresApp.tipPlanta;
      case 'electric':
        return ColoresApp.tipElectrico;
      case 'psychic':
        return ColoresApp.tipPsiquico;
      case 'ice':
        return ColoresApp.tipHielo;
      case 'dragon':
        return ColoresApp.tipDragon;
      case 'dark':
        return ColoresApp.tipSiniestro;
      case 'fairy':
        return ColoresApp.tipHada;
      case 'normal':
        return ColoresApp.tipNormal;
      case 'fighting':
        return ColoresApp.tipLucha;
      case 'flying':
        return ColoresApp.tipVolador;
      case 'poison':
        return ColoresApp.tipVeneno;
      case 'ground':
        return ColoresApp.tipTierra;
      case 'rock':
        return ColoresApp.tipRoca;
      case 'bug':
        return ColoresApp.tipBicho;
      case 'ghost':
        return ColoresApp.tipFantasma;
      case 'steel':
        return ColoresApp.tipAcero;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PokemonViewModel>();

    if (vm.loading) {
      return const PokemonGridShimmerLoading();
    }

    if (vm.errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                vm.errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => vm.cargarPokemons(),
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

    if (vm.pokemons.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.catching_pokemon, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No hay pokémon disponibles',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: vm.pokemons.length + (vm.isLoadingMore ? 2 : 0),
      itemBuilder: (context, index) {
        if (index >= vm.pokemons.length) {
          return const Card(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final pokemon = vm.pokemons[index];
        final primaryColor = pokemon.types.isNotEmpty
            ? _getTypeColor(pokemon.types.first)
            : Colors.grey;

        return Card(
          elevation: 3,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PokemonDetailPage(pokemon: pokemon),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ícono del pokémon
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          primaryColor.withOpacity(0.6),
                          primaryColor.withOpacity(0.3),
                        ],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.catching_pokemon,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Número
                  Text(
                    '#${pokemon.id.toString().padLeft(3, '0')}',
                    style: TipografiaApp.numeroPokemon.copyWith(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Nombre
                  Text(
                    pokemon.name.toUpperCase(),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TipografiaApp.nombrePokemon.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Tipos
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    alignment: WrapAlignment.center,
                    children: pokemon.types.take(2).map((type) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: _getTypeColor(type),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          type.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
