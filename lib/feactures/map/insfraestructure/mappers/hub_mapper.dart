import 'package:app_ciudadano_vc/feactures/map/domain/entities/hub_entiti.dart';

class HubMapper {
  static Hub fromJson(Map<String, dynamic> json) {
    return Hub(
      id: json['id'],
      nombre: json['nombre'],
      direccion: json['direccion'],
      ubicacion: UbicationMapper.fromJson(json['ubicacion']),
      cantidadElectrica: json['cantidad_electrica'],
      cantidadMecanica: json['cantidad_mecanica'],
      capacidadElectricas: json['capacidad_electrica'],
      capacidadMecanicas: json['capacidad_mecanica'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class UbicationMapper {
  static Ubicacion fromJson(Map<String, dynamic> json) {
    return Ubicacion(
      lat: json['lat'],
      long: json['long'],
    );
  }
}
