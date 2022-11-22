import 'package:barkibu/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomButtonSeeAnswers extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData icon;
  const CustomButtonSeeAnswers(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        )),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.primary, size: 14),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(color: AppTheme.primary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
