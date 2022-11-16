import 'package:flutter/material.dart';

Future<void> customShowDialog({
  required BuildContext context,
  required String title,
  required String message,
  bool isDismissible = true,
  String textButton = 'Cerrar',
  Function? onPressed,
}) async {
  if (isDismissible) {
    Navigator.of(context).pop();
  }

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          isDismissible
              ? TextButton(
                  child: Text(textButton),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onPressed != null) {
                      onPressed();
                    }
                  })
              : const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Center(child: CircularProgressIndicator()),
                ),
        ],
      );
    },
  );
}
