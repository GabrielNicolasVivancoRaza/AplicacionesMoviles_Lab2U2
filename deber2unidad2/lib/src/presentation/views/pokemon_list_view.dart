import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/post_viewmodel.dart';
import '../themes/indice.dart';
import '../widgets/pokemon_shimmer_loading.dart';
import 'pokemon_detail_page.dart';

class PokemonListView extends StatefulWidget {
  const PokemonListView({super.key});

  @override
  State<PokemonListView> createState() => _PokemonListViewState();
}

class _PokemonListViewState extends State<PokemonListView> {
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
      return const PokemonShimmerLoading();
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

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(12),
      itemCount: vm.pokemons.length + (vm.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= vm.pokemons.length) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final pokemon = vm.pokemons[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: ColoresApp.primario.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: ColoresApp.primario.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.catching_pokemon,
                size: 35,
                color: ColoresApp.primario,
              ),
            ),
            title: Text(
              pokemon.name.toUpperCase(),
              style: TipografiaApp.nombrePokemon,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Wrap(
                spacing: 6,
                runSpacing: 4,
                children: pokemon.types.map((type) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getTypeColor(type),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      type.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '#${pokemon.id.toString().padLeft(3, '0')}',
                  style: TipografiaApp.numeroPokemon.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: ColoresApp.textoSecundario,
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PokemonDetailPage(pokemon: pokemon),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
