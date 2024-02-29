import 'package:formz/formz.dart';

// Define input validation errors
enum EmailInputError { empty }

// Extend FormzInput and provide the input type and error type.
class EmailInput extends FormzInput<String, EmailInputError> {
  // Call super.pure to represent an unmodified form input.
  const EmailInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const EmailInput.dirty(String value) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  EmailInputError? validator(String value) {
    return value.isEmpty ? EmailInputError.empty : null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == EmailInputError.empty) return 'El campo es requerido';

    return null;
  }
}
