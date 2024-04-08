

class User {
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

  User({
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
  });
}


// {
//     "nombre":"holaa",
//     "apellido":"etc",
//     "fecha_nacimiento":"31/12/2001",
//     "numero_celular":"34234234",
//     "documento_numero":"42519217",
//     "foto":"www.google.com/url",
//     "documento_frontal":"www.google.com/url",
//     "documento_dorsal":"www.google.com/url",
//     "email":"drober@hotmali.com",
//     "genero":"M"
// }