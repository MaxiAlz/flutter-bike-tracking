import 'package:flutter/material.dart';

class CustomFilledButtom extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;

  const CustomFilledButtom(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.color,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonStyles = ButtonStyle(
      minimumSize: MaterialStateProperty.all<Size>(const Size(300, 50)),
    );

    const textStylesButton =
        TextStyle(fontWeight: FontWeight.normal, fontSize: 20);

    return FilledButton(
      onPressed: onPressed,
      style: buttonStyles,
      child: Text(
        text,
        style: textStylesButton,
      ),
    );
  }
}
