import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PetScreen extends StatelessWidget {
  const PetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tarjeta Veterinaria'),
        ),
        body: const Center(
          child: Text('PetScreen'),
        ),
        bottomNavigationBar: const CustomBottomNavigationPetOwner(
          currentIndex: 0,
        ));
  }
}
