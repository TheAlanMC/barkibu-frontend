import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class PetOwnerSettingsScreen extends StatelessWidget {
  const PetOwnerSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CardContainer(
                  child: CustomTextButton(
                    text: 'Mi cuenta',
                    subtext: 'Editar información',
                    icon: Icons.account_circle,
                    size: 60,
                    fontSize: 20,
                    onPressed: () => Navigator.of(context).pushNamed('/pet_owner_account_screen'),
                  ),
                ),
                CardContainer(
                  child: CustomTextButton(
                    text: 'Mis mascotas',
                    subtext: 'Añade o edita tus mascotas',
                    size: 60,
                    fontSize: 20,
                    icon: Icons.pets,
                    onPressed: () => Navigator.of(context).pushNamed('/pet_owner_pets_screen'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationPetOwner(
        currentIndex: 0,
      ),
    );
  }
}
