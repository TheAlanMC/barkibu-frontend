import 'package:barkibu/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool cancel;
  final double fontSize;
  const CustomMaterialButton({super.key, required this.text, this.onPressed, this.cancel = false, this.fontSize = 18});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      disabledColor: AppTheme.secondary,
      elevation: 0,
      color: cancel ? AppTheme.alert : AppTheme.primary,
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
        child: Text(
          text,
          style: TextStyle(color: AppTheme.textButton, fontSize: fontSize),
        ),
      ),
    );
  }
}
