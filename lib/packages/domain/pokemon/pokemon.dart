import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  const Pokemon({
    required this.name,
    required this.url,
    required this.selected,
    required this.imageUrl,
  });

  final String name;
  final String url;
  final bool selected;
  final String imageUrl;

  Pokemon copyWith({
    String? name,
    String? url,
    bool? selected,
    String? imageUrl,
  }) =>
      Pokemon(
        name: name ?? this.name,
        url: url ?? this.url,
        selected: selected ?? this.selected,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  @override
  List<Object?> get props => [
        name,
        url,
        selected,
        imageUrl,
      ];
}
