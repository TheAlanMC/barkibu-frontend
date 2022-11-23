import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PetOwnerPetsScreen extends StatelessWidget {
  const PetOwnerPetsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Menu'),
          centerTitle: true,
        ),
        body: Center(
            child: CardContainer(
                child: Column(
          children: [
            CustomTextButton(text: 'Toby', icon: Icons.pets, onPressed: () => Navigator.of(context).pushNamed('/pet_owner_pets_data_screen')),
            const SizedBox(height: 40),
            CustomTextButton(
              text: 'Añadir mascota',
              icon: Icons.add,
              onPressed: () => Navigator.of(context).pushNamed('/pet_owner_register_pet_screen'),
            ),
            const SizedBox(height: 40),
          ],
        ))),
        bottomNavigationBar: const CustomBottomNavigationPetOwner(
          currentIndex: 0,
        ));
  }
}
