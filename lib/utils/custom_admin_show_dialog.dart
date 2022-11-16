import 'package:flutter/material.dart';

Future<void> customAdminShowDialog(BuildContext context) async {
  Navigator.of(context).pop();

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('ÉXITO'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Inicio de sesión exitoso'),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: const Text('Dueño de mascota'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/pet_owner_pet_screen');
                },
              ),
              TextButton(
                child: const Text('Veterinario'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/veterinary_profile_screen');
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}
