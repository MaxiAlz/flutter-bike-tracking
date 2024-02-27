import 'package:flutter/material.dart';

class CustomCenterFloatingActionButton extends StatelessWidget {
  final IconData icon;
  final String? text;
  final VoidCallback onPressed;

  const CustomCenterFloatingActionButton(
      {super.key, required this.icon, this.text = '', required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: colors.primary,
      child: Icon(
        icon,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
