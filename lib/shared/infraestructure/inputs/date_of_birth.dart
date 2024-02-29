import 'package:formz/formz.dart';

enum DateOfBirthValidationError { empty, validFormat }

class DateOfBirth extends FormzInput<String, DateOfBirthValidationError> {
  const DateOfBirth.pure() : super.pure('');
  const DateOfBirth.dirty([String value = '']) : super.dirty(value);

  @override
  DateOfBirthValidationError? validator(String value) {
    // return value.isEmpty ? NameValidationError.empty : null;

    if (value.trim().isEmpty) return DateOfBirthValidationError.empty;

    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == DateOfBirthValidationError.empty) {
      return 'El campo es requerido';
    }

    return null;
  }
}
