// ignore_for_file: use_build_context_synchronously

import 'package:barkibu/screens/screens.dart';
import 'package:barkibu/services/login_service.dart';
import 'package:barkibu/utils/token_secure_storage.dart';
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
                Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (_, __, ___) => LoginScreen(), transitionDuration: Duration.zero));
              });
            } else {
              Future.microtask(() async {
                try {
                  List<String> groups = await LoginService.getGroups(snapshot.data!);
                  if (groups.contains('ADMINISTRADOR') || (groups.contains('DUEÑO DE MASCOTA') && groups.contains('VETERINARIO'))) {
                    Navigator.pushReplacement(
                        context, PageRouteBuilder(pageBuilder: (_, __, ___) => const SelectionScreen(), transitionDuration: Duration.zero));
                  } else {
                    if (groups.contains('DUEÑO DE MASCOTA')) {
                      Navigator.pushReplacement(
                          context, PageRouteBuilder(pageBuilder: (_, __, ___) => const PetOwnerPetsScreen(), transitionDuration: Duration.zero));
                    } else {
                      Navigator.pushReplacement(
                          context, PageRouteBuilder(pageBuilder: (_, __, ___) => const CheckVeterinarianScreen(), transitionDuration: Duration.zero));
                    }
                  }
                } catch (_) {
                  TokenSecureStorage.deleteTokens();
                  Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (_, __, ___) => LoginScreen(), transitionDuration: Duration.zero));
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
