import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_api_app/app/app.dart';
import 'package:poke_api_app/features/home/bloc/home_bloc.dart';
import 'package:poke_api_app/packages/domain/pokemon/pokemon_repository.dart';
import 'package:poke_api_app/packages/repositories/repositories.dart';

part 'dependencies/dependencies_dev.dart';

void main() => runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<PokemonRepository>(
            create: (context) => _pokemonRepository,
          ),
        ],
        child: BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
          child: const MyApp(),
        ),
      ),
    );
