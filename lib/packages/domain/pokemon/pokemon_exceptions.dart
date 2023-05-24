import 'package:equatable/equatable.dart';

class PokemonException extends Equatable implements Exception {
  const PokemonException(this.message);

  final String message;
  @override
  List<Object?> get props => [message];
}

class GetAllPokemonException extends PokemonException {
  const GetAllPokemonException(String message) : super(message);
}

class GetImagePokemonException extends PokemonException {
  const GetImagePokemonException(String message) : super(message);
}

class GetDetailsPokemonException extends PokemonException {
  const GetDetailsPokemonException(String message) : super(message);
}
