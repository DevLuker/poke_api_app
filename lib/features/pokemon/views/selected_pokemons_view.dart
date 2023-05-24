// ignore_for_file: no_default_cases
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_api_app/app/utils/constants.dart';
import 'package:poke_api_app/features/pokemon/bloc/pokemon_bloc.dart';
import 'package:poke_api_app/packages/domain/pokemon/pokemon_details.dart';

class SelectedPokemonsView extends StatelessWidget {
  const SelectedPokemonsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          switch (state.status) {
            case PokemonStatus.loading:
              return const CircularProgressIndicator();

            case PokemonStatus.error:
              return const Text(detailsPokemonNotLoaded);

            default:
              final pokemons = state.pokemonsDetails;
              if (pokemons.isEmpty) {
                return const Text(unselectedPokemon);
              }

              return SelectedPokemonsLoaded(pokemons: pokemons);
          }
        },
      ),
    );
  }
}

class SelectedPokemonsLoaded extends StatelessWidget {
  const SelectedPokemonsLoaded({Key? key, required this.pokemons})
      : super(key: key);
  final List<PokemonDetails> pokemons;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Card(
            child: Column(
              children: [
                SizedBox(
                  width: 200,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CachedNetworkImage(
                      imageUrl: pokemon.imageUrl,
                      placeholder: (context, url) => const SizedBox(),
                    ),
                  ),
                ),
                Text(
                  pokemon.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'EXPERIENCIA: ${pokemon.baseExperience} % ',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'SLOTS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...pokemon.abilities.map(
                  (e) => Text(
                    e.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
