import 'package:barkibu/theme/app_theme.dart';
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
    );
  }
}
