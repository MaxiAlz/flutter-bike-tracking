import 'package:app_ciudadano_vc/feactures/auth/domain/entities/user.dart';

class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> json) {
    return User(
        userId: json['id'] ?? '',
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
        documentStatus: json['estado_documentacion'] ?? '',
        isActive: json['is_active'] ?? false,
        isInTrip: json['en_viaje'] ?? false,
        tripData:
            json['viaje'] != null ? viajeJsonToEntity(json['viaje']) : null);
  }

  static Viaje viajeJsonToEntity(Map<String, dynamic> json) {
    return Viaje(
      id: json['id'] ?? 0,
      fechaFinalizacion: json['fecha_finalizacion'],
      duracion: json['duracion'],
      estado: json['estado'] ?? '',
      bicicletaId: json['bicicleta_id'] ?? 0,
      usuarioId: json['usuario_id'] ?? 0,
      administradorInicioId: json['administrador_inicio_id'] ?? 0,
      administradorFinalId: json['administrador_final_id'],
      estacionInicioId: json['estacion_inicio_id'] ?? 0,
      estacionFinalId: json['estacion_final_id'],
      fechaInicio: json['fecha_inicio'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
