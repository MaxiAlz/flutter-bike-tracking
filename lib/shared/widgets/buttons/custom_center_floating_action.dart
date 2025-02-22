import 'package:flutter/material.dart';

class CustomCenterFloatingActionButton extends StatelessWidget {
  final IconData icon;
  final String? text;
  final void Function()? onPressed;
  final double sizeIcon;
  final double widthButton;

  const CustomCenterFloatingActionButton(
      {super.key,
      required this.icon,
      this.text = '',
      required this.onPressed,
      this.sizeIcon = 30,
      this.widthButton = 60});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: widthButton, // Adjust width and height for desired size
      // height: 80.0,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: colors.primary,
          tooltip: "Escanea tu bici",
          child: Icon(
            icon,
            color: onPressed == null ? Colors.white24 : Colors.white,
            size: sizeIcon,
          ),
        ),
      ),
    );
  }
}
