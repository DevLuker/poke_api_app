part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class GoToAllPokemons extends HomeEvent {
  const GoToAllPokemons();
}

class GoToSelectedPokemons extends HomeEvent {
  const GoToSelectedPokemons();
}
