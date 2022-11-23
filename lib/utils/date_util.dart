import 'package:flutter/material.dart';

class DateUtil {
  static Future<String?> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      return '''${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}''';
    } else {
      return null;
    }
  }

  static String currentDate() {
    DateTime now = DateTime.now();
    return '''${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}''';
  }

  static String getDateString(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    final years = difference.inDays ~/ 365;
    if (years > 0) {
      return years == 1 ? 'Hace $years año' : 'Hace $years años';
    } else if (difference.inDays > 0) {
      return difference.inDays == 1 ? 'Hace ${difference.inDays} día' : 'Hace ${difference.inDays} días';
    } else if (difference.inHours > 0) {
      return difference.inHours == 1 ? 'Hace ${difference.inHours} hora' : 'Hace ${difference.inHours} horas';
    } else if (difference.inMinutes > 0) {
      return difference.inMinutes == 1 ? 'Hace ${difference.inMinutes} minuto' : 'Hace ${difference.inMinutes} minutos';
    } else {
      return 'Hace un momento';
    }
  }

  static String getPetAge(DateTime birthDate) {
    final now = DateTime.now();
    final difference = now.difference(birthDate);
    final years = difference.inDays ~/ 365;
    if (years > 0) {
      return years == 1 ? '$years año' : '$years años';
    } else {
      final months = difference.inDays ~/ 30;
      if (months > 0) {
        return months == 1 ? '$months mes' : '$months meses';
      } else {
        final weeks = difference.inDays ~/ 7;
        if (weeks > 0) {
          return weeks == 1 ? '$weeks semana' : '$weeks semanas';
        } else {
          return difference.inDays == 1 ? '${difference.inDays} día' : '${difference.inDays} días';
        }
      }
    }
  }
}
