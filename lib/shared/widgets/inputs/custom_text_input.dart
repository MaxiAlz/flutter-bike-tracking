import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VBCustomTextInput extends StatelessWidget {
  final int? sizeBoxHeight;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final String hintText;
  final String labelText;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final String? errorMessage;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final String? initialValue;
  final bool? isEnabled;

  const VBCustomTextInput({
    super.key,
    this.sizeBoxHeight,
    this.inputFormatters,
    required this.hintText,
    required this.labelText,
    this.keyboardType,
    this.onChanged,
    this.validator,
    this.initialValue,
    this.errorMessage,
    this.controller,
    this.focusNode,
    this.isEnabled,
    this.onEditingComplete,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          onSaved: onSaved,
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          validator: validator,
          initialValue: initialValue,
          onEditingComplete: onEditingComplete,
          inputFormatters: inputFormatters,
          enabled: isEnabled,
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
