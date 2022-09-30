import 'package:barkibu/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  final String text;
  const CustomMaterialButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      disabledColor: AppTheme.secondary,
      elevation: 0,
      color: AppTheme.primary,
      onPressed: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
