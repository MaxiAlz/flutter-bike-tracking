import 'package:formz/formz.dart';

enum NameValidationError { empty }

class NameInput extends FormzInput<String, NameValidationError> {
  const NameInput.pure() : super.pure('');
  const NameInput.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError? validator(String value) {
    // return value.isEmpty ? NameValidationError.empty : null;

    if (value.trim().isEmpty) return NameValidationError.empty;

    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == NameValidationError.empty) {
      return 'El campo es requerido';
    }

    return null;
  }
}
