import 'package:flutter/material.dart';

Future<String> selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),
  );
  if (picked != null) {
    return '''${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}''';
  } else {
    return '';
  }
}

String currentDate() {
  DateTime now = DateTime.now();
  return '''${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}''';
}
