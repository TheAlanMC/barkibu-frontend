import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final Color border;
  final String path;
  final double size;
  const CustomCircleAvatar({
    Key? key,
    required this.border,
    required this.path,
    this.size = 45,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundColor: border,
      child: CircleAvatar(
        radius: size - 5,
        backgroundImage: AssetImage(path),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
