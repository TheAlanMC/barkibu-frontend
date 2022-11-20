import 'dart:io';

import 'package:barkibu/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String photoPath;
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size),
          child: getImage(photoPath),
        ),
      ),
    );
  }

  Widget getImage(String? photoPath) {
    if (photoPath == null || photoPath.isEmpty) {
      return const Image(image: AssetImage('assets/no-image.png'), fit: BoxFit.cover);
    }
    if (photoPath.startsWith('http')) {
      return FadeInImage(
        placeholder: const AssetImage('assets/jar-loading.gif'),
        image: NetworkImage(photoPath),
        fit: BoxFit.cover,
        imageErrorBuilder: (_, __, ___) {
          return const Image(image: AssetImage('assets/no-image.png'), fit: BoxFit.cover);
        },
      );
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
