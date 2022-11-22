// ignore_for_file: use_build_context_synchronously
import 'package:barkibu/services/login_service.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:flutter/material.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: TokenSecureStorage.readToken(),
          builder: (BuildContext build, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            if (snapshot.data == '') {
              Future.microtask(() {
                SkipAnimation.pushReplacement(context, '/login_screen');
              });
            } else {
              Future.microtask(() async {
                try {
                  List<String> groups = await LoginService.getGroups();
                  if (groups.contains('ADMINISTRADOR') || (groups.contains('DUEÑO DE MASCOTA') && groups.contains('VETERINARIO'))) {
                    SkipAnimation.pushReplacement(context, '/selection_screen');
                  } else {
                    if (groups.contains('DUEÑO DE MASCOTA')) {
                      SkipAnimation.pushReplacement(context, '/pet_owner_pet_screen'); //pet owener pet screen
                    } else {
                      SkipAnimation.pushReplacement(context, '/check_veterinarian_screen');
                    }
                  }
                } catch (_) {
                  TokenSecureStorage.deleteTokens();
                  SkipAnimation.pushReplacement(context, '/login_screen');
                }
              });
            }

            return Container();
          },
        ),
      ),
    );
  }
}
