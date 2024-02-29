import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VBCustomTextInput extends StatelessWidget {
  final int? sizeBoxHeight;
  final List<TextInputFormatter>? inputFormatters;
  final String hintText;
  final String labelText;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final String? errorMessage;
  final String? Function(String?)? validator;

  const VBCustomTextInput(
      {super.key,
      this.sizeBoxHeight,
      this.inputFormatters,
      required this.hintText,
      required this.labelText,
      this.keyboardType,
      this.onChanged,
      this.validator,
      this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          onChanged: onChanged,
          validator: validator,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
              errorText: errorMessage,
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)),
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
