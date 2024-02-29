import 'package:formz/formz.dart';

enum FileValidationError { empty }

class File extends FormzInput<String, FileValidationError> {
  const File.pure() : super.pure('');
  const File.dirty([String value = '']) : super.dirty(value);

  @override
  FileValidationError? validator(String value) {
    // return value.isEmpty ? NameValidationError.empty : null;

    if (value.trim().isEmpty) return FileValidationError.empty;

    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == FileValidationError.empty) {
      return 'El campo es requerido';
    }

    return null;
  }
}
