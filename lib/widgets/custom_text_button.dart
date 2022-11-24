import 'package:barkibu/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData icon;
  final double? fontSize;
  final double? size;
  final String? subtext;
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.icon,
    this.fontSize = 18,
    this.size = 18,
    this.subtext,
  });

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
          Icon(icon, color: AppTheme.primary, size: size),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(color: AppTheme.primary, fontSize: fontSize, fontWeight: FontWeight.bold),
              ),
              if (subtext != null)
                Text(
                  subtext!,
                  style: TextStyle(color: AppTheme.primary, fontSize: fontSize! * 0.8),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
