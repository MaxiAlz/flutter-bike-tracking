import 'package:flutter/material.dart';

class CustomOutlineButtom extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? color;
  final Color? textColor;
  final MaterialStatesController? statesController;
  final Icon? icon;

  const CustomOutlineButtom(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.color,
      this.textColor,
      this.statesController,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonStyles = ButtonStyle(
      minimumSize: MaterialStateProperty.all<Size>(const Size(300, 50)),
    );

    const textStylesButton =
        TextStyle(fontWeight: FontWeight.normal, fontSize: 20);

    return OutlinedButton(
      onPressed: onPressed,
      statesController: statesController,
      style: buttonStyles,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) icon!,
          Text(
            text,
            style: textStylesButton,
          ),
        ],
      ),
    );
  }
}
