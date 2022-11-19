import 'package:barkibu/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool cancel;
  final double horizontalPadding;
  const CustomMaterialButton({super.key, required this.text, this.onPressed, this.cancel = false, this.horizontalPadding = 70});

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
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 15),
        child: Text(
          text,
          style: const TextStyle(color: AppTheme.textButton, fontSize: 18),
        ),
      ),
    );
  }
}
