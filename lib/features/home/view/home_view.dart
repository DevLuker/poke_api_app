import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_api_app/app/app.dart';
import 'package:poke_api_app/features/home/bloc/home_bloc.dart';
import 'package:poke_api_app/features/pokemon/bloc/pokemon_bloc.dart';
import 'package:poke_api_app/features/pokemon/views/views.dart';
import 'package:poke_api_app/features/widgets/widgets.dart';
import 'package:poke_api_app/packages/domain/pokemon/pokemon_repository.dart';

const _views = [
  AllPokemonsView(),
  SelectedPokemonsView(),
];

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonBloc(context.read<PokemonRepository>()),
      child: const HomeBodyView(),
    );
  }
}

class HomeBodyView extends StatelessWidget {
  const HomeBodyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.red,
          title: const Text(textTitleAppBar),
          centerTitle: true,
        ),
        drawer: const CustomDrawer(),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            final index = state.index;
            return _views[index];
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () => context
                    .read<PokemonBloc>()
                    .add(const ResetPokemonSelection()),
                child: const Text(textReset),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
