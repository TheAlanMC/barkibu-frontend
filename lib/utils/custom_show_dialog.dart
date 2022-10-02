import 'package:flutter/material.dart';

Future<void> customShowDialog(BuildContext context, String title, String message, bool closeable) async {
  isThereCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent != true;
  if (isThereCurrentDialogShowing(context)) {
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
          closeable
              ? TextButton(
                  child: const Text('Cerrar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              : const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Center(child: CircularProgressIndicator()),
                ),
        ],
      );
    },
  );
}
