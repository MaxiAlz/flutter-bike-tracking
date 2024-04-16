import 'package:flutter/material.dart';

class CustomFilledButtom extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final MaterialStatesController? statesController;

  const CustomFilledButtom(
      {
        Key? key,
      required this.text,
      required this.onPressed,
      this.color,
      this.textColor,
      this.statesController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonStyles = ButtonStyle(
      minimumSize: MaterialStateProperty.all<Size>(const Size(300, 50)),
    );

    const textStylesButton =
        TextStyle(fontWeight: FontWeight.normal, fontSize: 20);

    return FilledButton(
      statesController: statesController,
      onPressed: onPressed,
      style: buttonStyles,
      child: Text(
        text,
        style: textStylesButton,
      ),
    );
  }
}
