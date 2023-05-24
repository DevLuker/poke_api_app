part of '../main_dev.dart';

final _dio = Dio(
  BaseOptions(
    baseUrl: 'https://pokeapi.co/api/v2/',
  ),
);

final PokemonRepository _pokemonRepository = HttpPokemonRepository(_dio);
