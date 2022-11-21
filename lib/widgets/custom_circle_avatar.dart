import 'dart:io';

import 'package:barkibu/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String? photoPath;
  final double size;
  const CustomCircleAvatar({
    Key? key,
    required this.photoPath,
    this.size = 45,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundColor: AppTheme.secondary,
      child: CircleAvatar(
        radius: size - 5,
        backgroundColor: Colors.transparent,
        backgroundImage: getImage(photoPath).image,
      ),
    );
  }

  Image getImage(String? photoPath) {
    if (photoPath == null || photoPath.isEmpty) {
      return const Image(image: AssetImage('assets/no-image.png'), fit: BoxFit.cover);
    }
    if (photoPath.startsWith('http')) {
      return Image.network(photoPath, fit: BoxFit.cover);
    } else if (photoPath.startsWith('assets')) {
      return Image(
        image: AssetImage(photoPath),
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(photoPath),
        fit: BoxFit.cover,
      );
    }
  }
}
