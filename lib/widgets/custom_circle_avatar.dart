import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final Color border;
  final String path;
  const CustomCircleAvatar({
    Key? key,
    required this.border,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 45,
      backgroundColor: border,
      child: CircleAvatar(
        radius: 40,
        backgroundImage: AssetImage(path),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
