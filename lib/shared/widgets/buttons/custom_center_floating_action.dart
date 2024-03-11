import 'package:flutter/material.dart';

class CustomCenterFloatingActionButton extends StatelessWidget {
  final IconData icon;
  final String? text;
  final VoidCallback onPressed;
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
          onPressed: () {},
          backgroundColor: colors.primary,
          tooltip: "Escanea tu bici",
          child: Icon(
            icon,
            color: Colors.white,
            size: sizeIcon,
          ),
        ),
      ),
    );
  }
}
