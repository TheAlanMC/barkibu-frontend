import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Usuario'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              TokenSecureStorage.deleteTokens();
              Navigator.of(context).popAndPushNamed('/login_screen');
            },
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardContainer(
                  child: Column(
                    children: [
                      const Image(image: AssetImage('assets/barkibu_logo.png'), height: 120),
                      const SizedBox(height: 40),
                      CustomMaterialButton(
                        text: 'DUEÑO DE MASCOTA',
                        onPressed: () => Navigator.of(context).popAndPushNamed('/check_pet_owner_screen'),
                        horizontalPadding: 40,
                      ),
                      const SizedBox(height: 40),
                      CustomMaterialButton(
                        text: 'VETERINARIO',
                        onPressed: () => Navigator.of(context).popAndPushNamed('/check_veterinarian_screen'),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
