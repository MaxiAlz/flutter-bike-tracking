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
  });
}
