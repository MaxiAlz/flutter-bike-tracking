import 'package:formz/formz.dart';

enum GenderValidationError { empty, validFormat }

class Gender extends FormzInput<String, GenderValidationError> {
  const Gender.pure() : super.pure('');
  const Gender.dirty([String value = '']) : super.dirty(value);

  @override
  GenderValidationError? validator(String value) {
    // return value.isEmpty ? NameValidationError.empty : null;

    if (value.trim().isEmpty) return GenderValidationError.empty;

    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == GenderValidationError.empty) {
      return 'El campo es requerido';
    }

    return null;
  }
}
