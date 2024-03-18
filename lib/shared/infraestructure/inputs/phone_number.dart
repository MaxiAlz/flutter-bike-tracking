import 'package:formz/formz.dart';

// Define input validation errors
enum PhoneNumberError { empty, invalidFormat, length }

// Extend FormzInput and provide the input type and error type.
class PhoneNumber extends FormzInput<String, PhoneNumberError> {
  // Define the length of the phone number
  static const int phoneNumberLength = 12;

  static const String defaultCountryCode = '+54 9';

  // Call super.pure to represent an unmodified form input.
  const PhoneNumber.pure() : super.pure('');

  const PhoneNumber.dirty(String value) : super.dirty(value);

  factory PhoneNumber.withDefaultCountryCode() {
    return const PhoneNumber.dirty(defaultCountryCode);
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PhoneNumberError.empty) return 'El campo es requerido';
    if (displayError == PhoneNumberError.invalidFormat) {
      return 'No olvide el codigo de pais. Ej: +54 9';
    }
    if (displayError == PhoneNumberError.length) {
      return 'Formato de teléfono inválido';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  PhoneNumberError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PhoneNumberError.empty;

    if (!value.replaceAll(RegExp(r'[^0-9]'), '').startsWith('5')) {
      return PhoneNumberError.invalidFormat;
    }
    if (value.replaceAll(RegExp(r'[^0-9]'), '').length < phoneNumberLength) {
      return PhoneNumberError.length;
    }

    // Additional validation if necessary, e.g., to check if it contains only digits.

    return null;
  }
}


  // final phoneNumberWithoutMask =
  //       state.phoneNumber.value.replaceAll(RegExp(r'[^0-9]'), '');
