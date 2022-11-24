import 'package:barkibu/theme/app_theme.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationPetOwner extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavigationPetOwner({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppTheme.background,
      showUnselectedLabels: true,
      selectedItemColor: AppTheme.primary,
      unselectedItemColor: AppTheme.secondary,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Mascotas'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Vacunas'),
        BottomNavigationBarItem(icon: Icon(Icons.medical_services), label: 'Consultas'),
        BottomNavigationBarItem(icon: Icon(Icons.contact_support), label: 'Preguntas'),
      ],
      onTap: (index) {
        if (currentIndex != index) {
          switch (index) {
            case 0:
              SkipAnimation.pushAndRemoveUntil(context, '/pet_owner_pet_info_screen');
              break;
            case 1:
              // TODO: CHANGE THIS !!!
              SkipAnimation.pushAndRemoveUntil(context, '/pet_owner_pet_screen');
              break;
            case 2:
              SkipAnimation.pushAndRemoveUntil(context, '/pet_owner_own_question');
              break;
            case 3:
              SkipAnimation.pushAndRemoveUntil(context, '/pet_owner_question');
              break;
          }
        }
      },
    );
  }
}
