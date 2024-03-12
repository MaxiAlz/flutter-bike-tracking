// import 'package:app_ciudadano_vc/config/config.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_provider.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/inputs/inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
// import 'package:go_router/go_router.dart';

// #3 crear instancia del proveedor para usarlo en el widget
final authFormProvider =
    StateNotifierProvider<AuthFormNotifier, AuthFormState>((ref) {
  final loginUSerCallback = ref.watch(authProvider.notifier).loginUSer;

  return AuthFormNotifier(loginUserCallback: loginUSerCallback);
});

// #1 Definir el estado del formulario:
class AuthFormState {
  final bool isLoading;

  final bool isPhoneNumberSubmitted;
  final bool isVerificationCodeSubmitted;

  final bool isPhoneNumberValid;
  final bool isVerificationCodeValid;

  final String? errorMessage;
  final PhoneNumber phoneNumber;
  final ValidateCode verificationCode;

  AuthFormState({
    this.isLoading = false,
    this.isPhoneNumberSubmitted = false,
    this.isVerificationCodeSubmitted = false,
    this.isPhoneNumberValid = false,
    this.isVerificationCodeValid = false,
    this.errorMessage,
    PhoneNumber? phoneNumber = const PhoneNumber.pure(),
    this.verificationCode = const ValidateCode.pure(),
  }) : phoneNumber = phoneNumber ?? PhoneNumber.withDefaultCountryCode();

  AuthFormState copyWith({
    bool? isLoading,
    bool? isPhoneNumberSubmitted,
    bool? isVerificationCodeSubmitted,
    bool? isPhoneNumberValid,
    bool? isVerificationCodeValid,
    String? errorMessage,
    PhoneNumber? phoneNumber,
    ValidateCode? verificationCode,
  }) =>
      AuthFormState(
        isLoading: isLoading ?? this.isLoading,
        isPhoneNumberSubmitted:
            isPhoneNumberSubmitted ?? this.isPhoneNumberSubmitted,
        isVerificationCodeSubmitted:
            isVerificationCodeSubmitted ?? this.isVerificationCodeSubmitted,
        isPhoneNumberValid: isPhoneNumberValid ?? this.isPhoneNumberValid,
        isVerificationCodeValid:
            isVerificationCodeValid ?? this.isVerificationCodeValid,
        errorMessage: errorMessage ?? this.errorMessage,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        verificationCode: verificationCode ?? this.verificationCode,
      );
}

// #2 notificador del estado del formualrio
class AuthFormNotifier extends StateNotifier<AuthFormState> {
  final Function(String) loginUserCallback;
  AuthFormNotifier({required this.loginUserCallback}) : super(AuthFormState());

  onPhoneNumberChange(String value) {
    final newPhoneNumber = PhoneNumber.dirty(value);

    state = state.copyWith(
        phoneNumber: newPhoneNumber,
        isPhoneNumberValid:
            Formz.validate([newPhoneNumber, state.phoneNumber]));
  }

  onSubmitPhoneNumber(BuildContext context) async {
    _touchedPhoneNumberField();
    if (!state.isPhoneNumberValid) return;

    final phoneNumberWithoutMask =
        state.phoneNumber.value.replaceAll(RegExp(r'[^0-9]'), '');

    await loginUserCallback(phoneNumberWithoutMask);
    // context.push('/enter-code');

  }

  _touchedPhoneNumberField() {
    final phoneNumber = PhoneNumber.dirty(state.phoneNumber.value);
    print('====maskFormatter====>>>>>>>>>>> $phoneNumber), ' ')}');
    state = state.copyWith(
        isLoading: false,
        isPhoneNumberSubmitted: true,
        phoneNumber: phoneNumber,
        isPhoneNumberValid: Formz.validate(
          [phoneNumber],
        ));
  }
}
