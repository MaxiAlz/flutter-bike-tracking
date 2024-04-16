import 'package:app_ciudadano_vc/feactures/auth/domain/entities/user.dart';

class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> json) {
    return User(
      name: json['nombre'] ?? '',
      lastName: json['apellido'] ?? '',
      dateOfBirth: json['fecha_nacimiento'] ?? '',
      phoneNumber: json['numero_celular'] ?? '',
      dniNumber: json['documento_numero'] ?? '',
      photo: json['foto'] ?? '',
      dniFront: json['documento_frontal'] ?? '',
      dniBack: json['documento_dorsal'] ?? '',
      email: json['email'] ?? '',
      gender: json['genero'] ?? '',
    );
  }
}
