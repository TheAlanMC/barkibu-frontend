import 'package:barkibu/router/app_routes.dart';
import 'package:flutter/material.dart';

class SkipAnimation {
  static void pushNamed(BuildContext context, String routeName) {
    Widget page = AppRoutes.routes.firstWhere((element) => element.route == routeName).screen;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionDuration: Duration.zero,
      ),
    );
  }

  static void pushAndRemoveAll(BuildContext context, String routeName) {
    Widget page = AppRoutes.routes.firstWhere((element) => element.route == routeName).screen;
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionDuration: Duration.zero,
      ),
      (route) => false,
    );
  }
}
