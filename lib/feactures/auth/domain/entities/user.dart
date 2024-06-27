class User {
  final int userId;
  final String name;
  final String lastName;
  final String dateOfBirth;
  final String phoneNumber;
  final String dniNumber;
  final String photo;
  final String dniFront;
  final String dniBack;
  final String email;
  final String gender;
  final String documentStatus;
  final bool isActive;
  final bool isInTrip;
  final Viaje? tripData;

  User( {
    required this.userId,
    required this.documentStatus,
    required this.isActive,
    required this.name,
    required this.lastName,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.dniNumber,
    required this.photo,
    required this.dniFront,
    required this.dniBack,
    required this.email,
    required this.gender,
    required this.isInTrip,
    this.tripData,
  });
}

class Viaje {
  final int id;
  final String? fechaFinalizacion;
  final String? duracion;
  final String estado;
  final int bicicletaId;
  final int usuarioId;
  final int administradorInicioId;
  final int? administradorFinalId;
  final int estacionInicioId;
  final int? estacionFinalId;
  final String fechaInicio;
  final String updatedAt;

  Viaje({
    required this.id,
    this.fechaFinalizacion,
    this.duracion,
    required this.estado,
    required this.bicicletaId,
    required this.usuarioId,
    required this.administradorInicioId,
    this.administradorFinalId,
    required this.estacionInicioId,
    this.estacionFinalId,
    required this.fechaInicio,
    required this.updatedAt,
  });
}