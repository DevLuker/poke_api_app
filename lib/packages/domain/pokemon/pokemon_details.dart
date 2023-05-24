import 'package:equatable/equatable.dart';

class PokemonDetails extends Equatable {
  const PokemonDetails({
    required this.name,
    required this.imageUrl,
    required this.baseExperience,
    required this.abilities,
  });

  final String name;
  final String imageUrl;
  final int baseExperience;
  final List<Abilities> abilities;

  @override
  List<Object?> get props => [name, imageUrl, baseExperience, abilities];
}

class Abilities extends Equatable {
  const Abilities({
    required this.name,
    required this.slot,
  });
  final String name;
  final int slot;

  @override
  List<Object?> get props => [name, slot];
}
