import 'package:flutter/material.dart';
import 'package:password_strength/password_strength.dart';

Widget passwordStrengthIndicator(String password) {
  final strength = estimatePasswordStrength(password);
  return Column(
    children: [
      LinearProgressIndicator(
        value: strength,
        valueColor: AlwaysStoppedAnimation<Color>(_strengthColor(strength)),
      ),
      const SizedBox(height: 10),
      Text(
        _strengthText(strength),
        style: const TextStyle(fontSize: 12),
      ),
    ],
  );
}

Color _strengthColor(double strength) {
  if (strength < 0.3) {
    return Colors.red;
  } else if (strength < 0.6) {
    return Colors.orange;
  } else {
    return Colors.green;
  }
}

String _strengthText(double strength) {
  if (strength < 0.3) {
    return 'Muy débil';
  } else if (strength < 0.7) {
    return 'Débil';
  } else {
    return 'Fuerte';
  }
}
