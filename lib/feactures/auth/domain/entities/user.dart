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

  User({
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

  User copyWith({
    int? userId,
    String? name,
    String? lastName,
    String? dateOfBirth,
    String? phoneNumber,
    String? dniNumber,
    String? photo,
    String? dniFront,
    String? dniBack,
    String? email,
    String? gender,
    String? documentStatus,
    bool? isActive,
    bool? isInTrip,
    Viaje? tripData,
  }) {
    return User(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dniNumber: dniNumber ?? this.dniNumber,
      photo: photo ?? this.photo,
      dniFront: dniFront ?? this.dniFront,
      dniBack: dniBack ?? this.dniBack,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      documentStatus: documentStatus ?? this.documentStatus,
      isActive: isActive ?? this.isActive,
      isInTrip: isInTrip ?? this.isInTrip,
      tripData: tripData, 
    );
  }
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
