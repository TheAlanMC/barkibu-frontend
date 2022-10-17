import 'dart:io';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  final String? imagePath;

  const UserImage({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: getImage(imagePath),
    );
  }

  Widget getImage(String? picture) {
    if (picture == null) {
      return const Image(
        image: AssetImage('assets/no-image.png'),
        fit: BoxFit.cover,
        width: 150,
        height: 150,
      );
    }
    if (picture.startsWith('http')) {
      //TODO: add image from internet
      return FadeInImage(
        placeholder: const AssetImage('assets/no-image.png'),
        image: NetworkImage(picture),
        fit: BoxFit.cover,
        width: 150,
        height: 150,
      );
    } else {
      return Image.file(
        File(picture),
        fit: BoxFit.cover,
        width: 150,
        height: 150,
      );
    }
  }
}
