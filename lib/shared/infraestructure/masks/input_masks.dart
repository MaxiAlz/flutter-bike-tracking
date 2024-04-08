import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

enum MaskType { dniMask, phoneNumberMask, dateOfBirthMask }

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
    }
  }

  String getUnmaskedValue(
      {required String maskedValue, required MaskType maskType}) {
    switch (maskType) {
      case MaskType.dniMask:
      case MaskType.phoneNumberMask:
      case MaskType.dateOfBirthMask:
        return maskedValue.replaceAll(RegExp(r'[^\d]'), '');
    }
  }
}
