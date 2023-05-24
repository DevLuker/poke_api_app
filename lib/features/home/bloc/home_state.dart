part of 'home_bloc.dart';

enum HomeStatus { initial, loading }

class HomeState extends Equatable {
  const HomeState({
    required this.index,
    this.status = HomeStatus.loading,
  });

  final int index;
  final HomeStatus? status;

  HomeState copyWith({
    int? index,
    HomeStatus? status,
  }) =>
      HomeState(index: index ?? this.index, status: status ?? this.status);

  @override
  List<Object?> get props => [
        index,
        status,
      ];
}
