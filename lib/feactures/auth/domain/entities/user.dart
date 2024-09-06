import 'package:app_ciudadano_vc/feactures/trips/domain/entities/viaje_entity.dart';

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


