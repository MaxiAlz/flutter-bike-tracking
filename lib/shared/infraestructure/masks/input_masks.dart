import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

enum MaskType { dniMask, phoneNumberMask }

class InputMaskFormated {
  static MaskTextInputFormatter getMask({required MaskType maskType}) {
    
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
    }
  }
}
