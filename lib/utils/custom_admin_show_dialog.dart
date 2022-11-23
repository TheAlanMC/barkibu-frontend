import 'package:barkibu/theme/app_theme.dart';
import 'package:flutter/material.dart';

Future<void> customAdminShowDialog({required BuildContext context}) async {
  if (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
  }

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
              Text('¿Con qué cuenta desea ingresar?'),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // TODO: CHANGE THIS
                  Navigator.of(context).pushNamed('/pet_owner_pet_screen');
                },
                style: TextButton.styleFrom(
                  foregroundColor: AppTheme.textButton,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  disabledForegroundColor: AppTheme.secondary,
                  backgroundColor: AppTheme.primary,
                ),
                child: const Text('Dueño de mascota'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).popAndPushNamed('/veterinarian_profile_screen');
                },
                style: TextButton.styleFrom(
                  foregroundColor: AppTheme.textButton,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  disabledForegroundColor: AppTheme.secondary,
                  backgroundColor: AppTheme.primary,
                ),
                child: const Text('Veterinario'),
              ),
            ],
          ),
        ],
      );
    },
  );
}
