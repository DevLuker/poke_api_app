import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_api_app/app/app.dart';
import 'package:poke_api_app/features/home/bloc/home_bloc.dart';
import 'package:poke_api_app/features/pokemon/bloc/pokemon_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.watch<HomeBloc>();

    return Drawer(
      child: Column(
        children: [
          ListTile(
            leading: const CircleAvatar(
              child: FlutterLogo(),
            ),
            title: const Text('Luis Ramos'),
            subtitle: const Text('luisra.dev@gmail.com'),
            onTap: () => context.pop(),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: drawerItems.length,
              itemBuilder: (context, index) {
                final item = drawerItems[index];
                final isSelected = index == homeBloc.state.index;

                return ListTile(
                  leading: Icon(
                    item.icon,
                    color: isSelected ? AppColors.blue : null,
                  ),
                  title: Text(
                    item.title,
                    style: TextStyle(
                      color: isSelected ? AppColors.blue : null,
                      fontWeight: isSelected ? FontWeight.bold : null,
                    ),
                  ),
                  onTap: () {
                    item.onTap(context, homeBloc);
                    context.pop();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerItem {
  const DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final Function(BuildContext, HomeBloc) onTap;
}

final List<DrawerItem> drawerItems = [
  DrawerItem(
    icon: Icons.home,
    title: 'Lista de Pokemones',
    onTap: (context, homeBloc) {
      context.read<PokemonBloc>().add(const LoadAllPokemons());
      homeBloc.add(const GoToAllPokemons());
    },
  ),
  DrawerItem(
    icon: Icons.line_axis_outlined,
    title: 'Pokemones Seleccionados',
    onTap: (context, homeBloc) {
      context.read<PokemonBloc>().add(const LoadSelectedPokemons());
      homeBloc.add(const GoToSelectedPokemons());
    },
  ),
];
