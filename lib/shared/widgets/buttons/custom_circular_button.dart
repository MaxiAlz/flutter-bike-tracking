import 'package:flutter/material.dart';

class CustomCircularButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color iconColor;
  final Color labelColor;
  final VoidCallback onPressed;

  const CustomCircularButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    this.iconColor = Colors.white,
    this.labelColor = Colors.white,
    required this.onPressed,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            padding:
                EdgeInsets.all(15.0), // Ajusta el padding según sea necesario
            child: Icon(
              icon,
              color: iconColor,
              size: 50.0, // Tamaño del icono
            ),
          ),
        ),
        const SizedBox(height: 8.0), // Espacio entre el icono y el label
        Text(
          label,
          style: TextStyle(
            color: labelColor,
            fontSize: 16.0, // Tamaño del label
          ),
        ),
      ],
    );
  }
}
