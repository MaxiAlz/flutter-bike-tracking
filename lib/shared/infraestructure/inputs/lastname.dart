import 'package:formz/formz.dart';

enum LastnameInputError { empty }

class LastnameInput extends FormzInput<String, LastnameInputError> {
  // Call super.pure to represent an unmodified form input.
  const LastnameInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const LastnameInput.dirty(String value) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  LastnameInputError? validator(String value) {
    return value.trim().isEmpty ? LastnameInputError.empty : null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == LastnameInputError.empty) {
      return 'El campo es requerido';
    }

    return null;
  }
}
