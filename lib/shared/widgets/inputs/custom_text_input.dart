import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VBCustomTextInput extends StatelessWidget {
  final int? sizeBoxHeight;
  final List<TextInputFormatter>? inputFormatters;
  final String hintText;
  final String labelText;
  final TextInputType? keyboardType;

  const VBCustomTextInput(
      {super.key,
      this.sizeBoxHeight,
      this.inputFormatters,
      required this.hintText,
      required this.labelText,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: hintText,
              labelText: labelText),
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}
