import 'package:flutter_riverpod/flutter_riverpod.dart';

final authFormProvider =
    StateNotifierProvider<AuthFormNotifier, AuthFormState>((ref) {
  return AuthFormNotifier();
});

class AuthFormState {
  final String phoneNumber;
  final String verificationCode;
  final String phoneNumberUnmasked;
  final String verificationCodeUnmasked;

  AuthFormState({
    this.phoneNumber = '',
    this.verificationCode = '',
    this.phoneNumberUnmasked = '',
    this.verificationCodeUnmasked = '',
  });

  AuthFormState copyWith(
      {String? phoneNumber,
      String? verificationCode,
      String? phoneNumberUnmasked,
      String? verificationCodeUnmasked}) {
    return AuthFormState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      verificationCode: verificationCode ?? this.verificationCode,
      phoneNumberUnmasked: phoneNumberUnmasked ?? this.phoneNumberUnmasked,
      verificationCodeUnmasked:
          verificationCodeUnmasked ?? this.verificationCodeUnmasked,
    );
  }
}

class AuthFormNotifier extends StateNotifier<AuthFormState> {
  AuthFormNotifier() : super(AuthFormState());

  void printState() {
    print(state.toString());
  }

  void setPhoneNumber({required String newPhoneNumber}) {
    state = state.copyWith(phoneNumber: newPhoneNumber);
  }

  void setVerificationCode({required String newVerificationCode}) {
    state = state.copyWith(verificationCode: newVerificationCode);
  }

  void setUnmaskedValues(
      {required String phoneNumberUnmasked,
      required String verificationCodeUnmasked}) {
    state = state.copyWith(
        verificationCodeUnmasked: verificationCodeUnmasked,
        phoneNumberUnmasked: phoneNumberUnmasked);
  }
}
