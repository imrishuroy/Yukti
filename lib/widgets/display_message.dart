import 'package:flutter/material.dart';

const TextStyle _textStyle = TextStyle(color: Colors.white);

class ShowMessage {
  static void showErrorMessage(
    BuildContext context, {
    String message = 'Something went wrong :(',
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(seconds: 6),
        content: Text(
          message,
          style: _textStyle,
        ),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static void showSuccussMessage(
    BuildContext context, {
    String message = 'Operation Successfull',
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 6),
        content: Text(
          message,
          style: _textStyle,
        ),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
