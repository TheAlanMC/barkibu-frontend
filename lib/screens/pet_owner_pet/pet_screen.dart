import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PetScreen extends StatelessWidget {
  const PetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tarjeta Veterinaria'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () => Navigator.of(context).pushNamed('/pet_owner_settings_screen'), icon: const Icon(Icons.settings)),
            //TODO: DELETE THIS ICON AFTER TESTING
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                TokenSecureStorage.deleteTokens();
                SkipAnimation.pushReplacement(context, '/login_screen');
              },
            )
          ],
        ),
        body: const Center(
          child: Text('PetScreen'),
        ),
        bottomNavigationBar: const CustomBottomNavigationPetOwner(
          currentIndex: 0,
        ));
  }
}
