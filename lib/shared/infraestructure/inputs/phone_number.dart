import 'package:formz/formz.dart';

// Define input validation errors
enum PhoneNumberError { empty, invalidFormat }

// Extend FormzInput and provide the input type and error type.
class PhoneNumber extends FormzInput<String, PhoneNumberError> {
  // Define the length of the phone number
  static const int phoneNumberLength = 10;

  // Call super.pure to represent an unmodified form input.
  const PhoneNumber.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const PhoneNumber.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PhoneNumberError.empty) return 'El campo es requerido';
    if (displayError == PhoneNumberError.invalidFormat) {
      return 'Formato de teléfono inválido';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  PhoneNumberError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PhoneNumberError.empty;

    if (value.replaceAll(RegExp(r'[^0-9]'), '').length != phoneNumberLength) {
      return PhoneNumberError.invalidFormat;
    }

    // Additional validation if necessary, e.g., to check if it contains only digits.

    return null;
  }
}


  // final phoneNumberWithoutMask =
  //       state.phoneNumber.value.replaceAll(RegExp(r'[^0-9]'), '');
