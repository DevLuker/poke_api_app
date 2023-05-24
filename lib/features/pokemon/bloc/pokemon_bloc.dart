import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poke_api_app/packages/domain/domain.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

const _initialState = PokemonState(
  pokemons: [],
  status: PokemonStatus.initial,
  selectedCount: 0,
  pokemonsDetails: [],
);

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc(this._pokemonRepository) : super(_initialState) {
    on<LoadAllPokemons>(_onLoadPokemons);
    on<LoadSelectedPokemons>(_onLoadSelectedPokemons);
    on<TogglePokemonSelection>(_onTogglePokemonSelection);
    on<ResetPokemonSelection>(_onResetPokemonSelection);
  }

  final PokemonRepository _pokemonRepository;

  PokemonState get _buildLoadingState =>
      state.copyWith(status: PokemonStatus.loading);

  PokemonState get _buildErrorState =>
      state.copyWith(status: PokemonStatus.error);

  PokemonState get _buildLoadedState =>
      state.copyWith(status: PokemonStatus.loaded);

  Future<void> _onLoadPokemons(
    LoadAllPokemons event,
    Emitter<PokemonState> emit,
  ) async {
    emit(_buildLoadingState);
    try {
      final response = await _pokemonRepository.getAllPokemon();
      emit(_buildLoadedState.copyWith(pokemons: response));
    } on GetAllPokemonException catch (_) {
      emit(state.copyWith(status: PokemonStatus.error));
    }
  }

  void _onTogglePokemonSelection(
    TogglePokemonSelection event,
    Emitter<PokemonState> emit,
  ) {
    final currentState = state;
    final updatedPokemons = List<Pokemon>.from(currentState.pokemons);

    final selectedPokemon = updatedPokemons[event.index];
    final updatedPokemon = selectedPokemon.copyWith(selected: event.value);
    updatedPokemons[event.index] = updatedPokemon;

    final selectedCount =
        updatedPokemons.where((pokemon) => pokemon.selected).length;

    if (selectedCount <= 2) {
      final updatedState = currentState.copyWith(
        pokemons: updatedPokemons,
        selectedCount: selectedCount,
      );
      emit(updatedState);
    } else {
      emit(currentState);
    }
  }

  Future<void> _onLoadSelectedPokemons(
    LoadSelectedPokemons event,
    Emitter<PokemonState> emit,
  ) async {
    emit(_buildLoadingState);

    final pokemonsDetails = <PokemonDetails>[];
    final filterPokemons =
        state.pokemons.where((e) => e.selected == true).toList();

    for (final pokemon in filterPokemons) {
      try {
        final response =
            await _pokemonRepository.getPokemonsDetails(pokemon.name);
        pokemonsDetails.add(response);
      } on GetDetailsPokemonException catch (_) {
        emit(_buildErrorState.copyWith(pokemonsDetails: [], selectedCount: 0));
      }
    }

    emit(
      _buildLoadedState.copyWith(
        pokemonsDetails: pokemonsDetails,
        selectedCount: 0,
      ),
    );
  }

  void _onResetPokemonSelection(
    ResetPokemonSelection event,
    Emitter<PokemonState> emit,
  ) {
    final updatedPokemons = state.pokemons.map((pokemon) {
      return pokemon.copyWith(selected: false);
    }).toList();

    emit(
      state.copyWith(
        pokemons: updatedPokemons,
        pokemonsDetails: [],
        selectedCount: 0,
      ),
    );
  }
}
