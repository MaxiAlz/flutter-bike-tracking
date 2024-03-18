import 'dart:io';

class User {
  final int id;
  final String email;
  final String name;
  final String lastName;
  final String token;
  // final Gender gender;
  final String gender;
  final String dni;
  final String phoneNumber;
  final bool? isActive;
  final /* DateTime */ String birthDay;
  final File? profileImage;
  final File? dniFrontImage;
  final File? dniBackImage;

  User(
      {this.isActive,
      required this.phoneNumber,
      this.profileImage,
      this.dniFrontImage,
      this.dniBackImage,
      required this.birthDay,
      required this.id,
      required this.email,
      required this.name,
      required this.lastName,
      required this.token,
      required this.gender,
      required this.dni});

  // bool get isUserActive {

  //   return isUserActive;
  // }
}

enum Gender {
  masculino,
  femenino,
  sinEspecificar,
  otraIdentidad,
}
