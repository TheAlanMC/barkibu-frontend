import 'package:barkibu/router/app_routes.dart';
import 'package:flutter/material.dart';

class SkipAnimation {
  static void pushReplacement(BuildContext context, String routeName) {
    Widget page = AppRoutes.routes.firstWhere((element) => element.route == routeName).screen;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionDuration: Duration.zero,
      ),
    );
  }
}
