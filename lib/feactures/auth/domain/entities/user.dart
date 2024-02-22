import 'dart:io';

class User {
  final String id;
  final String email;
  final String name;
  final String lastName;
  final String token;
  final Gender gender;
  final int dni;
  final int phoneNumber;
  final bool isActive;
  final DateTime birthDay;
  final File profileImage;
  final File? dniFrontImage;
  final File? dniBackImage;

  User(this.isActive, this.phoneNumber, this.profileImage, this.dniFrontImage,
      this.dniBackImage, this.birthDay,
      {required this.id,
      required this.email,
      required this.name,
      required this.lastName,
      required this.token,
      required this.gender,
      required this.dni});

  bool get isUserActive {
    return isActive;
  }
}

enum Gender {
  masculino,
  femenino,
  sinEspecificar,
  otraIdentidad,
}
