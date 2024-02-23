import 'package:app_ciudadano_vc/shared/infraestructure/inputs/validate_code.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

final enterCodePRovider =
    StateNotifierProvider<EnterCodeNotifier, EnterCodeState>(
        (ref) => EnterCodeNotifier());

class EnterCodeState {
  final bool isLoading;
  final bool isCodeSubmitted;
  final bool isCodeValid;
  final String? errorMessage;
  final ValidateCode validateCode;

  EnterCodeState({
    this.isLoading = false,
    this.isCodeSubmitted = false,
    this.isCodeValid = false,
    this.errorMessage,
    this.validateCode = const ValidateCode.pure(),
  });

  EnterCodeState copyWith({
    bool? isLoading,
    bool? isCodeSubmitted,
    bool? isCodeValid,
    String? errorMessage,
    ValidateCode? validateCode,
  }) {
    return EnterCodeState(
      isLoading: isLoading ?? this.isLoading,
      isCodeSubmitted: isCodeSubmitted ?? this.isCodeSubmitted,
      isCodeValid: isCodeValid ?? this.isCodeValid,
      errorMessage: errorMessage ?? this.errorMessage,
      validateCode: validateCode ?? this.validateCode,
    );
  }
}

class EnterCodeNotifier extends StateNotifier<EnterCodeState> {
  EnterCodeNotifier() : super(EnterCodeState());

  onChangeValidateCode(String value) {
    final newValidateCode = ValidateCode.dirty(value);
    state = state.copyWith(
        validateCode: newValidateCode,
        isCodeValid: Formz.validate([newValidateCode, state.validateCode]));
  }

  onSubmitValidateCode() {
    _touchedValidateCodeField();
    if (!state.isCodeValid) return;
    final validateNumberWithoutMask =
        state.validateCode.value.replaceAll(RegExp(r'[^0-9]'), '');

    print('=>>>>>>>>>>>> $validateNumberWithoutMask');
  }

  _touchedValidateCodeField() {
    final validateCode = ValidateCode.dirty(state.validateCode.value);

    state = state.copyWith(
        isLoading: false,
        isCodeSubmitted: true,
        validateCode: validateCode,
        errorMessage: '',
        isCodeValid: Formz.validate(
          [validateCode],
        ));
  }
}
