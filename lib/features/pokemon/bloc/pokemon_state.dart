part of 'pokemon_bloc.dart';

enum PokemonStatus {
  initial,
  loading,
  error,
  loaded,
}

class PokemonState extends Equatable {
  const PokemonState({
    required this.pokemons,
    required this.pokemonsDetails,
    required this.status,
    required this.selectedCount,
  });

  final List<Pokemon> pokemons;
  final List<PokemonDetails> pokemonsDetails;

  final PokemonStatus status;
  final int selectedCount;

  bool get maxSelectedCount => selectedCount == 2;

  PokemonState copyWith({
    List<Pokemon>? pokemons,
    PokemonStatus? status,
    int? selectedCount,
    List<PokemonDetails>? pokemonsDetails,
  }) =>
      PokemonState(
        pokemons: pokemons ?? this.pokemons,
        status: status ?? this.status,
        selectedCount: selectedCount ?? this.selectedCount,
        pokemonsDetails: pokemonsDetails ?? this.pokemonsDetails,
      );

  @override
  List<Object?> get props => [
        pokemons,
        status,
        selectedCount,
        pokemonsDetails,
      ];
}
