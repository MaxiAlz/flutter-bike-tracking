class Hub {
  int id;
  String nombre;
  String direccion;
  Ubicacion ubicacion;
  int cantidadBicicletas;
  int capacidadElectrica;
  int capacidadMecanica;
  DateTime createdAt;
  DateTime updatedAt;

  Hub({
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.ubicacion,
    required this.cantidadBicicletas,
    required this.capacidadElectrica,
    required this.capacidadMecanica,
    required this.createdAt,
    required this.updatedAt,
  });
}

class Ubicacion {
  double lat;
  double long;

  Ubicacion({
    required this.lat,
    required this.long,
  });
}
