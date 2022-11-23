import 'package:barkibu/theme/app_theme.dart';
import 'package:flutter/material.dart';

Future<void> customLoginShowDialog({required BuildContext context, required List<String> groups}) async {
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
            children: [
              const Text('Inicio de sesión exitoso'),
              if (groups.length > 1) const Text('¿Con qué cuenta desea ingresar?'),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          if (groups.length > 1)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (groups.contains('ADMINISTRADOR'))
                  SizedBox(
                    width: 200,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).popAndPushNamed('/admin_screen');
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppTheme.textButton,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        disabledForegroundColor: AppTheme.secondary,
                        backgroundColor: AppTheme.primary,
                      ),
                      child: const Text('Administrador'),
                    ),
                  ),
                if (groups.contains('DUEÑO DE MASCOTA'))
                  SizedBox(
                    width: 200,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).popAndPushNamed('/pet_owner_pet_info_screen');
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
                  ),
                if (groups.contains('VETERINARIO'))
                  SizedBox(
                    width: 200,
                    child: TextButton(
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
                  ),
              ],
            )
          else
            TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                  switch (groups[0]) {
                    case 'ADMINISTRADOR':
                      Navigator.of(context).popAndPushNamed('/admin_screen');
                      break;
                    case 'DUEÑO DE MASCOTA':
                      Navigator.of(context).popAndPushNamed('/pet_owner_pet_info_screen');
                      break;
                    case 'VETERINARIO':
                      Navigator.of(context).popAndPushNamed('/veterinarian_profile_screen');
                      break;
                  }
                })
        ],
      );
    },
  );
}
