import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

enum MaskType { dniMask, phoneNumberMask, dateOfBirthMask, verificationCode }

class InputMaskFormated {
  MaskTextInputFormatter getMask({required MaskType maskType}) {
    switch (maskType) {
      case MaskType.dniMask:
        return MaskTextInputFormatter(
          mask: '##.###.###',
          filter: {"#": RegExp(r'[0-9]')},
          type: MaskAutoCompletionType.lazy,
        );

      case MaskType.phoneNumberMask:
        return MaskTextInputFormatter(
          mask: '(###) ###-####',
          filter: {"#": RegExp(r'[0-9]')},
          type: MaskAutoCompletionType.lazy,
        );

      case MaskType.dateOfBirthMask:
        return MaskTextInputFormatter(
          mask: '##/##/####',
          filter: {"#": RegExp(r'[0-9]')},
          type: MaskAutoCompletionType.eager,
        );
      case MaskType.verificationCode:
        return MaskTextInputFormatter(
          mask: '#-#-#-#',
          filter: {"#": RegExp(r'[0-9]')},
          type: MaskAutoCompletionType.eager,
        );
    }
  }

  String getUnmaskedValue(
      {required String maskedValue, required MaskType maskType}) {
    switch (maskType) {
      case MaskType.dniMask:
      case MaskType.phoneNumberMask:
      case MaskType.dateOfBirthMask:
      case MaskType.verificationCode:
        return maskedValue.replaceAll(RegExp(r'[^\d]'), '');
    }
  }

  String applyMask({required String value, required MaskType maskType}) {
    MaskTextInputFormatter maskFormatter = getMask(maskType: maskType);
    TextEditingValue textEditingValue = maskFormatter.formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(text: value),
    );
    return textEditingValue.text;
  }
}
