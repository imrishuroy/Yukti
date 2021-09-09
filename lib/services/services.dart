import 'package:flutter/material.dart';

class Services {
  static Future<bool> askToAction(BuildContext context,
      {required String title, required String content}) async {
    final bool? result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'No',
                style: TextStyle(color: Colors.green),
              ),
            )
          ],
        );
      },
    );

    return result ?? false;
  }
}
