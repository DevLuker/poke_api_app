// ignore_for_file: no_default_cases
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_api_app/app/utils/constants.dart';
import 'package:poke_api_app/features/pokemon/bloc/pokemon_bloc.dart';
import 'package:poke_api_app/features/widgets/widgets.dart';

class AllPokemonsView extends StatefulWidget {
  const AllPokemonsView({Key? key}) : super(key: key);

  @override
  State<AllPokemonsView> createState() => _AllPokemonsViewState();
}

class _AllPokemonsViewState extends State<AllPokemonsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Evitar la carga de nuevo del pokemon
      //context.read<PokemonBloc>().add(const LoadAllPokemons());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          switch (state.status) {
            case PokemonStatus.loaded:
              return const ListPokemons();
            case PokemonStatus.error:
              return const Text(errorLoadingPokemon);
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class ListPokemons extends StatelessWidget {
  const ListPokemons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<PokemonBloc>().state;
    final pokemons = bloc.pokemons;
    return ListView.builder(
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];
        return Card(
          child: ListTile(
            leading: Image.network(pokemon.imageUrl),
            title: Text(pokemon.name),
            trailing: Checkbox(
              value: pokemon.selected,
              onChanged: (value) {
                if (value == true && bloc.maxSelectedCount) {
                  showDialog<void>(
                    context: context,
                    builder: (context) => const CustomAlert(),
                  );
                }
                context.read<PokemonBloc>().add(
                      TogglePokemonSelection(index: index, value: value!),
                    );
              },
            ),
          ),
        );
      },
    );
  }
}
