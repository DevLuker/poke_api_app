import 'package:flutter/material.dart';
import 'package:poke_api_app/app/config/config.dart';
import 'package:poke_api_app/app/routes/app_route.dart';
import 'package:poke_api_app/app/utils/constants.dart';

export 'package:poke_api_app/app/config/config.dart';
export 'package:poke_api_app/app/routes/app_route.dart';
export 'package:poke_api_app/app/utils/utils.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: buildTheme(context),
      routerConfig: goRouterConfig,
      debugShowCheckedModeBanner: false,
      title: appTitle,
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaleFactor: 1,
          ),
          child: child!,
        );
      },
    );
  }
}
