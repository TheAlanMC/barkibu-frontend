import 'package:barkibu/models/models.dart';
import 'package:barkibu/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  //Inicio de sesión - Registro
  static const intialRoute = '/';
  static final routes = <MenuOption>[
    MenuOption(
      route: '/register_user_screen',
      screen: RegisterUserScreen(),
    ),
    MenuOption(
      route: '/register_pet_screen',
      screen: const RegisterPetScreen(),
    ),
    MenuOption(
      route: '/register_pet_vaccine_screen',
      screen: const RegisterPetVaccineScreen(),
    ),
    MenuOption(
      route: '/password_recover_screen1',
      screen: const PasswordRecoverScreen1(),
    ),
    MenuOption(
      route: '/password_recover_screen2',
      screen: const PasswordRecoverScreen2(),
    ),
    MenuOption(
      route: '/password_recover_screen3',
      screen: PasswordRecoverScreen3(),
    ),
    MenuOption(
      route: '/pet_owner_pet_screen',
      screen: const PetScreen(),
    ),
     MenuOption(
      route: '/pet_owner_settings_screen',
      screen: const PetOwnerSettingsScreen(),
    ),
    MenuOption(
      route: '/veterinary_profile_screen',
      screen: const VeterinaryProfileScreen(),
    ),
  ];

  //mapa de rutas
  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({'/': (BuildContext context) => LoginScreen()});
    for (final option in routes) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }
    return appRoutes;
  }

  //ruta por defecto
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const AlertScreen());
  }
}
