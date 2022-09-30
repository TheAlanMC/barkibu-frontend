import 'package:barkibu/models/models.dart';
import 'package:barkibu/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  //Inicio de sesión - Registro
  static const intialRoute = '/';
  static final menuOptions = <MenuOption>[
    MenuOption(
      route: '/register_first_screen',
      screen: const RegisterFirstScreen(),
    ),
  ];

  //mapa de rutas
  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({'/': (BuildContext context) => const LoginScreen()});
    for (final option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }
    return appRoutes;
  }

  //ruta por defecto
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const AlertScreen());
  }
}
