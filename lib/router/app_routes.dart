import 'package:barkibu/models/models.dart';
import 'package:barkibu/screens/screens.dart';
import 'package:barkibu/screens/veterinarian_profile/veterinary_profile_last_answer.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  //Inicio de sesión - Registro
  static const intialRoute = '/';
  static final routes = <MenuOption>[
    MenuOption(
      route: '/login_screen',
      screen: LoginScreen(),
    ),
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
      screen: PasswordRecoverScreen1(),
    ),
    MenuOption(
      route: '/password_recover_screen2',
      screen: PasswordRecoverScreen2(),
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
      route: '/pet_owner_account_screen',
      screen: PetOwnerAccountScreen(),
    ),
    MenuOption(
      route: '/pet_owner_change_password_screen',
      screen: const PetOwnerChangePassword(),
    ),
    MenuOption(
      route: '/pet_owner_pets_screen',
      screen: const PetOwnerPetsScreen(),
    ),
    MenuOption(
      route: '/pet_owner_pets_data_screen',
      screen: const PetOwnerPetsData(),
    ),
    MenuOption(route: '/pet_owner_own_question', screen: const OwnerOwnQuestionScreen()),
    MenuOption(
      route: '/veterinarian_profile_screen',
      screen: const VeterinarianProfileScreen(),
    ),
    MenuOption(
      route: '/veterinarian_profile_settings_screen',
      screen: const VeterinarianProfileSettingsScreen(),
    ),
    MenuOption(
      route: '/check_veterinarian_screen',
      screen: const CheckVeterinarianScreen(),
    ),
    MenuOption(
      route: '/veterinarian-register-veterinary_screen',
      screen: VeterinarianRegisterVeterinaryScreen(),
    ),
    MenuOption(
      route: '/selection_screen',
      screen: const SelectionScreen(),
    ),
    MenuOption(
      route: '/veterinarian_profile_edit_veterinary_screen',
      screen: const VeterinarianProfileEditVeterinaryScreen(),
    ),
    MenuOption(
      route: '/change_password_screen',
      screen: ChangePasswordScreen(),
    ),
    MenuOption(
      route: '/veterinarian_profile_last_answer_screen',
      screen: const VeterinaryProfileLastAnswerScreen(),
    ),
    MenuOption(
      route: '/veterinarian_question_screen',
      screen: const VeterinarianQuestionScreen(),
    ),
    MenuOption(
      route: '/veterinarian_question_filter_screen',
      screen: const VeterinarianQuestionFilterScreen(),
    ),
    MenuOption(
      route: '/veterinarian_question_detail_screen',
      screen: const VeterinarianQuestionDetailScreen(),
    ),
  ];

  //mapa de rutas
  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({'/': (BuildContext context) => const CheckAuthScreen()});
    // appRoutes.addAll({'/': (BuildContext context) => LoginScreen()});

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
