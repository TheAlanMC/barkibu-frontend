import 'package:barkibu/theme/app_theme.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationVeterinary extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavigationVeterinary({super.key, required this.currentIndex});

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
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        BottomNavigationBarItem(icon: Icon(Icons.contact_support), label: 'Preguntas'),
      ],
      onTap: (index) {
        if (currentIndex != index) {
          switch (index) {
            case 0:
              SkipAnimation.pushReplacement(context, '/check_veterinarian_screen');
              break;
            case 1:
              SkipAnimation.pushReplacement(context, '/veterinarian_question_screen');
              break;
          }
        }
      },
    );
  }
}
