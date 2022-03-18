import 'package:flutter/material.dart';

class Utils {
  static void showToast(BuildContext context, String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        action: SnackBarAction(label: 'Undo', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

}