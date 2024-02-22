import 'package:app_ciudadano_vc/feactures/shared/infraestructure/inputs/inputs.dart';
import 'package:formz/formz.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:riverpod/riverpod.dart';

// #3 crear instancia del proveedor para usarlo en el widget
final authFormProvider =
    StateNotifierProvider /* .autoDispose */ <AuthFormNotifier, AuthFormState>(
        (ref) {
// usar esto y pasar como argumento cuadno se tenga la llamada a la api
  // final authUserCallback = ref.watch(authProvider.notifier).loginUser;

  return AuthFormNotifier();
});

// #1 Definir el estado del formulario:
class AuthFormState {
  final bool isLoading;
  final bool isValid;
  final String? errorMessage;
  final PhoneNumber phoneNumber;

  AuthFormState(
      {this.isValid = false,
      this.phoneNumber = const PhoneNumber.pure(),
      this.isLoading = false,
      this.errorMessage});

  AuthFormState copyWith(
      {bool? isLoading,
      String? errorMessage,
      PhoneNumber? phoneNumber,
      bool? isValid}) {
    return AuthFormState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        isValid: isValid ?? this.isValid,
        phoneNumber: phoneNumber ?? this.phoneNumber);
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

    state = state.copyWith(phoneNumber: newPhoneNumber);
  }

  onSubmitPhoneNumber() async {
    // print('====onSubmitPhoneNumber====>>>>>>>>>>> ${state.phoneNumber.value}');
    final phoneNumberWithoutMask =
        state.phoneNumber.value.replaceAll(RegExp(r'[^0-9]'), '');

    print('====maskFormatter====>>>>>>>>>>> $phoneNumberWithoutMask), ' ')}');
  }

  onVerificationCodeChange(int verificationCode) {}
  onSubmitVerificationCode() async {}

  _touchedPhoneNumberField() {
    final phoneNumber = PhoneNumber.dirty(state.phoneNumber.value);
    state = state.copyWith(
        isLoading: false,
        phoneNumber: phoneNumber,
        errorMessage: '',
        isValid: Formz.validate(
          [phoneNumber],
        ));
  }
}
// 