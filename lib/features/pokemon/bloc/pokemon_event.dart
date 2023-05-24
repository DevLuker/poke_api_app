part of 'pokemon_bloc.dart';

abstract class PokemonEvent {
  const PokemonEvent();
}

class LoadAllPokemons extends PokemonEvent {
  const LoadAllPokemons();
}

class LoadSelectedPokemons extends PokemonEvent {
  const LoadSelectedPokemons();
}

class ResetPokemonSelection extends PokemonEvent {
  const ResetPokemonSelection();
}

class TogglePokemonSelection extends PokemonEvent {
  TogglePokemonSelection({
    required this.index,
    required this.value,
  });

  final int index;
  final bool value;
}
