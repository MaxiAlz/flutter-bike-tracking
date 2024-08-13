class Hub {
  int id;
  String nombre;
  String direccion;
  Ubicacion ubicacion;
  int cantidadElectrica;
  int cantidadMecanica;
  int capacidadElectricas;
  int capacidadMecanicas;
  DateTime createdAt;
  DateTime updatedAt;

  Hub({
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.ubicacion,
    required this.cantidadElectrica,
    required this.cantidadMecanica,
    required this.capacidadElectricas,
    required this.capacidadMecanicas,
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
