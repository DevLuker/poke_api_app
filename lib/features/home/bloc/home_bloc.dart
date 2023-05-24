import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

const _initialState = HomeState(index: 0);

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(_initialState) {
    on<GoToAllPokemons>(_onGoToAllPokemons);
    on<GoToSelectedPokemons>(_onGoToSelectedPokemons);
  }

  void _onGoToAllPokemons(
    GoToAllPokemons event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(index: 0, status: HomeStatus.initial));
  }

  void _onGoToSelectedPokemons(
    GoToSelectedPokemons event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(index: 1, status: HomeStatus.initial));
  }
}
