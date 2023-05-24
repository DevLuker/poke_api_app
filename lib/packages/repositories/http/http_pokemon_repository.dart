// ignore_for_file: avoid_dynamic_calls
// ignore_for_file: implicit_dynamic_parameter

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:poke_api_app/packages/domain/domain.dart';

class HttpPokemonRepository implements PokemonRepository {
  const HttpPokemonRepository(this._dioClient);
  final Dio _dioClient;

  @override
  Future<List<Pokemon>> getAllPokemon() async {
    const path = 'pokemon?limit=20';
    try {
      final response = await _dioClient.get<String>(path);
      if (response.statusCode != 200) {
        throw const GetAllPokemonException(
          'Ocurrió un error al obtener los pokemones',
        );
      }
      final data = json.decode(response.data!) as Map<String, dynamic>;
      final pokemonList = listPokemonFromMap(data);

      final imageFutures = <Future<void>>[];

      for (var i = 0; i < pokemonList.length; i++) {
        final pokemon = pokemonList[i];
        final imageUrl = await _fetchPokemonImage(pokemon.url);
        pokemonList[i] = pokemon.copyWith(imageUrl: imageUrl);
        imageFutures.add(Future.value());
      }

      await Future.wait(imageFutures);

      return pokemonList;
    } catch (e) {
      throw const GetAllPokemonException(
        'Ocurrió un error con el servicio',
      );
    }
  }

  Future<String> _fetchPokemonImage(String url) async {
    try {
      final response = await _dioClient.get<String>(url);
      if (response.statusCode != 200) {
        throw const GetImagePokemonException(
          'Ocurrió un error al obtener la imágen',
        );
      }
      final data = json.decode(response.data!) as Map<String, dynamic>;
      final sprites = data['sprites'] as Map<String, dynamic>;
      final frontDefault = sprites['front_default'] as String;
      return frontDefault;
    } catch (e) {
      throw const GetImagePokemonException(
        'Ocurrió un error con el servicio',
      );
    }
  }

  @override
  Future<PokemonDetails> getPokemonsDetails(String name) async {
    final path = 'pokemon/$name';
    try {
      final response = await _dioClient.get<String>(path);
      if (response.statusCode != 200) {
        throw const GetDetailsPokemonException(
          'Ocurrió un error al obtener el detalle del pokemón',
        );
      }
      final data = json.decode(response.data!) as Map<String, dynamic>;
      return pokemonDetailsFromMap(data);
    } catch (e) {
      throw const GetDetailsPokemonException(
        'Ocurrió un error con el servicio',
      );
    }
  }
}

List<Pokemon> listPokemonFromMap(Map<String, dynamic> data) {
  final results = data['results'] as List<dynamic>;
  return results.map((e) => pokemonFromMap(e as Map<String, dynamic>)).toList();
}

Pokemon pokemonFromMap(Map<String, dynamic> data) => Pokemon(
      name: data['name'] as String,
      url: data['url'] as String,
      selected: false,
      imageUrl: '',
    );

PokemonDetails pokemonDetailsFromMap(Map<String, dynamic> data) =>
    PokemonDetails(
      name: data['name'] as String,
      imageUrl: data['sprites']['other']['home']['front_default'] as String,
      baseExperience: data['base_experience'] as int,
      abilities: (data['abilities'] as List<dynamic>)
          .map((e) => abilitiesFromMap(e as Map<String, dynamic>))
          .toList(),
    );

Abilities abilitiesFromMap(Map<String, dynamic> data) => Abilities(
      name: data['ability']['name'] as String,
      slot: data['slot'] as int,
    );
