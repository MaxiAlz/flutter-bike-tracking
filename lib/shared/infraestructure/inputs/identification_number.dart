import 'package:formz/formz.dart';

enum IdentificationNumberValidationError { empty }

class IdentificationNumber
    extends FormzInput<String, IdentificationNumberValidationError> {
  const IdentificationNumber.pure() : super.pure('');
  const IdentificationNumber.dirty([String value = '']) : super.dirty(value);

  @override
  IdentificationNumberValidationError? validator(String value) {
    // return value.isEmpty ? NameValidationError.empty : null;

    if (value.trim().isEmpty) return IdentificationNumberValidationError.empty;

    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == IdentificationNumberValidationError.empty) {
      return 'El campo es requerido';
    }

    return null;
  }
}
