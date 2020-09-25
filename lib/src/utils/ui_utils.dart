import 'package:flutter/material.dart';

void mostrarAlert(
    {String textOk = 'Ok',
    String textCancel = 'Cancel',
    BuildContext context,
    String text,
    String title,
    VoidCallback onPressedOk}) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('$title'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('$text'),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('$textCancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text('$textOk'),
              onPressed: () {
                onPressedOk();
              },
            ),
          ],
        );
      });
}
