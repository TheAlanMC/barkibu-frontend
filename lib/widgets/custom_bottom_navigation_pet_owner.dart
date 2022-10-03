import 'package:barkibu/theme/app_theme.dart';
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
    );
  }
}
