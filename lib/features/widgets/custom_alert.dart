import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_api_app/app/app.dart';

class CustomAlert extends StatelessWidget {
  const CustomAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Alerta!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'No se puede seleccionar uno nuevo hasta liberar un espacio.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          MaterialButton(
            color: Colors.red,
            onPressed: () => context.pop(),
            child: const Text(
              'Aceptar',
              style: TextStyle(color: AppColors.white),
            ),
          )
        ],
      ),
    );
  }
}
