import 'package:flutter/material.dart';

Future<String> selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );
  if (picked != null) {
    return '${picked.day}-${picked.month}-${picked.year}';
  } else {
    return '';
  }
}
