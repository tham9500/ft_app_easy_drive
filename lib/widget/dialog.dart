import 'package:flutter/material.dart';

class Dialogs {
  Future<void> _showMyDialog(context, content) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("$content"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ปิด'),
              onPressed: () {
                int count = 0;
                Navigator.popUntil(context, (route) {
                  return count++ == 3;
                });
              },
            ),
          ],
        );
      },
    );
  }

  Widget test(context, content) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text("$content"),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('ปิด'),
          onPressed: () {
            int count = 0;
            Navigator.popUntil(context, (route) {
              return count++ == 3;
            });
          },
        ),
      ],
    );
  }

  Dialogs();
}
