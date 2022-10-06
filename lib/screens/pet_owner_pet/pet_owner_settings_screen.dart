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
        ),
        body: Center(
            child: CardContainer(
                child: Column(
          children: [
            CustomTextButton(
                text: 'Mi cuenta:',
                icon: Icons.account_circle,
                onPressed: () =>
                    Navigator.of(context).pushNamed('/account_owner_screen')),
            const SizedBox(height: 40),
            CustomTextButton(
              text: 'Mis mascotas',
              icon: Icons.pets,
              onPressed: () =>
                  Navigator.of(context).pushNamed('/owner_pets_screen'),
            ),
            const SizedBox(height: 40),
          ],
        ))),
        bottomNavigationBar: const CustomBottomNavigationPetOwner(
          currentIndex: 0,
        ));
  }
}
