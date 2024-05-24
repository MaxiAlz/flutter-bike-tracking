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


// class CustomDialog extends StatelessWidget {
//   final String title;
//   final String content;
//   final String primaryButtonText;
//   final VoidCallback primaryButtonAction;
//   final String secondaryButtonText;
//   final VoidCallback secondaryButtonAction;

//   const CustomDialog({
//     Key? key,
//     required this.title,
//     required this.content,
//     required this.primaryButtonText,
//     required this.primaryButtonAction,
//     required this.secondaryButtonText,
//     required this.secondaryButtonAction,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(title),
//       content: Text(content),
//       actions: <Widget>[
//         TextButton(
//           child: Text(secondaryButtonText),
//           onPressed: secondaryButtonAction,
//         ),
//         TextButton(
//           child: Text(primaryButtonText),
//           onPressed: primaryButtonAction,
//         ),
//       ],
//     );
//   }
// }
