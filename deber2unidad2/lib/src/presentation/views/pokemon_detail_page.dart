import 'package:flutter/material.dart';
import '../../domain/entities/post_entity.dart';
import '../themes/indice.dart';

class PokemonDetailPage extends StatelessWidget {
  final PokemonEntity pokemon;

  const PokemonDetailPage({super.key, required this.pokemon});

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
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name.toUpperCase()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icono del Pokémon sin imagen
            Center(
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColoresApp.primario.withOpacity(0.8),
                      ColoresApp.secundario.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(90),
                  boxShadow: [
                    BoxShadow(
                      color: ColoresApp.primario.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.catching_pokemon,
                  size: 100,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Número del Pokémon
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: ColoresApp.secundario.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: ColoresApp.secundario, width: 2),
              ),
              child: Text(
                '#${pokemon.id.toString().padLeft(3, '0')}',
                style: TipografiaApp.titulo.copyWith(
                  color: ColoresApp.primario,
                  fontSize: 28,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Nombre
            Text(
              pokemon.name.toUpperCase(),
              style: TipografiaApp.titulo.copyWith(fontSize: 32),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Tipos
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.category,
                          color: ColoresApp.primario,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'TIPOS',
                          style: TipografiaApp.subtitulo.copyWith(
                            color: ColoresApp.primario,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: pokemon.types.map((type) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: _getTypeColor(type),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: _getTypeColor(type).withOpacity(0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            type.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Estadísticas
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Altura',
                    '${(pokemon.height / 10).toStringAsFixed(1)} m',
                    Icons.height,
                    ColoresApp.acento,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Peso',
                    '${(pokemon.weight / 10).toStringAsFixed(1)} kg',
                    Icons.fitness_center,
                    ColoresApp.secundario,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.1),
              color.withOpacity(0.05),
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 36, color: color),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: TipografiaApp.texto.copyWith(
                color: ColoresApp.textoSecundario,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: TipografiaApp.titulo.copyWith(
                fontSize: 20,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
