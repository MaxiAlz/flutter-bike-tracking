import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDialog {
  void showUnderageDialog(
      {required BuildContext context,
      required WidgetRef ref,
      required String title,
      required Widget dialogContent,
      IconData? icondata}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final textTheme = Theme.of(context).textTheme;
        final colors = Theme.of(context).colorScheme;

        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                if (icondata != null) Icon(icondata, color: colors.primary),
                SizedBox(width: icondata != null ? 8.0 : 0),
                Text(
                  title,
                  style: textTheme.titleMedium,
                ),
              ],
            ),
          ),
          content: dialogContent,
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FilledButton(onPressed: () {}, child: Text('asd'))
          ],
        );
      },
    );
  }
}
