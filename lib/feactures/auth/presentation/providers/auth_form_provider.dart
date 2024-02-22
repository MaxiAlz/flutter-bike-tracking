import 'package:app_ciudadano_vc/shared/infraestructure/inputs/inputs.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/inputs/validate_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// import 'package:riverpod/riverpod.dart';

// #3 crear instancia del proveedor para usarlo en el widget
final authFormProvider =
    StateNotifierProvider<AuthFormNotifier, AuthFormState>((ref) {
// usar esto y pasar como argumento cuadno se tenga la llamada a la api
  // final authUserCallback = ref.watch(authProvider.notifier).loginUser;

  return AuthFormNotifier();
});

// #1 Definir el estado del formulario:
class AuthFormState {
  final bool isLoading;
  // final bool isFormPosted;

  final bool isPhoneNumberSubmitted;
  final bool isVerificationCodeSubmitted;

  final bool isPhoneNumberValid;
  final bool isVerificationCodeValid;

  final String? errorMessage;
  final PhoneNumber phoneNumber;
  final ValidateCode verificationCode;

  AuthFormState(
      {
      // this.isFormPosted = false,
      this.isPhoneNumberSubmitted = false,
      this.isVerificationCodeValid = false,
      this.isVerificationCodeSubmitted = false,
      this.verificationCode = const ValidateCode.pure(),
      this.phoneNumber = const PhoneNumber.pure(),
      this.isLoading = false,
      this.isPhoneNumberValid = false,
      this.errorMessage});

  AuthFormState copyWith(
      {bool? isLoading,
      bool? isFormPosted,
      bool? isPhoneNumberSubmitted,
      bool? isVerificationCodeSubmitted,
      String? errorMessage,
      PhoneNumber? phoneNumber,
      ValidateCode? verificationCode,
      bool? isPhoneNumberValid,
      bool? isVerificationCodeValid}) {
    return AuthFormState(
      isPhoneNumberSubmitted:
          isPhoneNumberSubmitted ?? this.isPhoneNumberSubmitted,
      isVerificationCodeSubmitted:
          isVerificationCodeSubmitted ?? this.isVerificationCodeSubmitted,
      isLoading: isLoading ?? this.isLoading,
      isPhoneNumberValid: isPhoneNumberValid ?? this.isPhoneNumberValid,
      isVerificationCodeValid:
          isVerificationCodeValid ?? this.isVerificationCodeValid,
      errorMessage: errorMessage ?? this.errorMessage,
      // isFormPosted: isFormPosted ?? this.isFormPosted,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      verificationCode: verificationCode ?? this.verificationCode,
    );
  }
}

// #2 notificador del estado del formualrio
class AuthFormNotifier extends StateNotifier<AuthFormState> {
  final maskFormatter = MaskTextInputFormatter();

  // final Function(String, String) authUserCallback;
  AuthFormNotifier(/* {required this.authUserCallback} */)
      : super(AuthFormState());

  // Métodos para actualizar el estado del formulario

  onPhoneNumberChange(String phoneNumber) {
    final newPhoneNumber = PhoneNumber.dirty(phoneNumber);
    state = state.copyWith(
        phoneNumber: newPhoneNumber,
        isPhoneNumberValid: Formz.validate([newPhoneNumber]));
  }

  onSubmitPhoneNumber(BuildContext context) async {
    _touchedPhoneNumberField();
    if (!state.isPhoneNumberValid) return;
    final phoneNumberWithoutMask =
        state.phoneNumber.value.replaceAll(RegExp(r'[^0-9]'), '');
    context.push('/enter-code');

    print('====maskFormatter====>>>>>>>>>>> $phoneNumberWithoutMask), ' ')}');

    state = state.copyWith(
      isPhoneNumberSubmitted: true,
    );
  }

  // onVerificationCodeChange(String verificationCode) {
  //   print('===>>>>>newVerificationCode>>>>>>>> ${verificationCode}');
  //   final newVerificationCode = ValidateCode.dirty(verificationCode);
  //   state = state.copyWith(
  //       verificationCode: newVerificationCode,
  //       isVerificationCodeValid: Formz.validate([newVerificationCode]));
  // }

  onVerificationCodeChange(String verificationCode) {
    print('===>>>>>newVerificationCode>>>>>>>> ${verificationCode}');
    final newVerificationCode = ValidateCode.dirty(verificationCode);
    final isCodeValid = Formz.validate([newVerificationCode]);

    if (isCodeValid != state.isVerificationCodeValid) {
      state = state.copyWith(
        verificationCode: newVerificationCode,
        isVerificationCodeValid: isCodeValid,
      );
    }
  }

  onSubmitVerificationCode() async {
    print('===>>>>>>>>>>>>>');
    // _touchedVerificationCodeField();
    // print('===verificationCode state==>>>> ${state.isVerificationCodeValid}');
    // if (!state.isVerificationCodeValid) return;
    // final verificationCodeWithoutMask =
    //     state.verificationCode.value.replaceAll(RegExp(r'[^0-9]'), '');
    // print(
    //     '====verificationCodeWithoutMas====>>>>>>>>>>> $verificationCodeWithoutMask), '
    //     ')}');
  }

  _touchedPhoneNumberField() {
    final phoneNumber = PhoneNumber.dirty(state.phoneNumber.value);

    state = state.copyWith(
        isLoading: false,
        isPhoneNumberSubmitted: true,
        phoneNumber: phoneNumber,
        errorMessage: '',
        isPhoneNumberValid: Formz.validate(
          [phoneNumber],
        ));
  }

  _touchedVerificationCodeField() {
    final verificationCode = ValidateCode.dirty(state.verificationCode.value);
    print(
        '====_touchedPVerificationCodeField====>>>>>>>>>>> $verificationCode), '
        ')}');
    state = state.copyWith(
        isLoading: false,
        isVerificationCodeSubmitted: true,
        verificationCode: verificationCode,
        errorMessage: '',
        isVerificationCodeValid: Formz.validate(
          [verificationCode],
        ));
  }
}
