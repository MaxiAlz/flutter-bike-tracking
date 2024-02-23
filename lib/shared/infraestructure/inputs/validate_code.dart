import 'package:formz/formz.dart';

// Define input validation errors
enum ValidateCodeError { empty, invalidFormat }

// Extend FormzInput and provide the input type and error type.
class ValidateCode extends FormzInput<String, ValidateCodeError> {
  // Define the length of the phone number
  static const int validateCodeLenght = 8;

  // Call super.pure to represent an unmodified form input.
  const ValidateCode.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const ValidateCode.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == ValidateCodeError.empty) return 'El campo es requerido';
    if (displayError == ValidateCodeError.invalidFormat) {
      return 'Formato invalido';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  ValidateCodeError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return ValidateCodeError.empty;

    if (value.replaceAll(RegExp(r'[^0-9]'), '').length != validateCodeLenght) {
      return ValidateCodeError.invalidFormat;
    }

    // Additional validation if necessary, e.g., to check if it contains only digits.

    return null;
  }
}


  // final phoneNumberWithoutMask =
  //       state.phoneNumber.value.replaceAll(RegExp(r'[^0-9]'), '');
