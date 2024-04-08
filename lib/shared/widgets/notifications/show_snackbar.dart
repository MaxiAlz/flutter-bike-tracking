import 'package:flutter/material.dart';

class ShowCustomSnackbar {
  show(
      {required BuildContext context,
      required String label,
      required Color color}) {
    final snackBar = SnackBar(
      content: Text(label),
      backgroundColor: color,
      action: SnackBarAction(
        label: 'Cerrar',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
