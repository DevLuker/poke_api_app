import 'package:poke_api_app/packages/domain/domain.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getAllPokemon();
  Future<PokemonDetails> getPokemonsDetails(String name);
}
