import 'package:flutter/material.dart';

class PetOwnerPetsData extends StatelessWidget {
  const PetOwnerPetsData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int petId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: Text(petId.toString()),
        centerTitle: true,
      ),
    );
  }
}
