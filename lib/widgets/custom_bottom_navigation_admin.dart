import 'package:barkibu/theme/app_theme.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationAdmin extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavigationAdmin({super.key, required this.currentIndex});

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
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.person_add), label: 'Registro'),
      ],
      onTap: (index) {
        if (currentIndex != index) {
          switch (index) {
            case 0:
              SkipAnimation.pushAndRemoveUntil(context, '/admin_home_screen');
              break;
            case 1:
              SkipAnimation.pushAndRemoveUntil(context, '/admin_register_user_veterinarian_screen');
              break;
          }
        }
      },
    );
  }
}
