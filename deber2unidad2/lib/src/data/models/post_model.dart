import '../../domain/entities/post_entity.dart';

class PokemonModel extends PokemonEntity {
  PokemonModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.height,
    required super.weight,
    required super.types,
  });

  // Convertir JSON en objeto
  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    List<String> typesList = [];
    if (json['types'] != null) {
      typesList = (json['types'] as List)
          .map((t) => t['type']['name'].toString())
          .toList();
    }

    return PokemonModel(
      id: json["id"] ?? 0,
      name: json["name"]?.toString() ?? 'Desconocido',
      imageUrl: json['sprites']?['front_default']?.toString() ?? '',
      height: json["height"] ?? 0,
      weight: json["weight"] ?? 0,
      types: typesList,
    );
  }
}
