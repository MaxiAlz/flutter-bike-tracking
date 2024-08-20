class MyTripsPaginated {
  final List<Viaje> items;
  final int total;
  final int current;
  final int pageSize;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final int totalPages;

  MyTripsPaginated({
    required this.items,
    required this.total,
    required this.current,
    required this.pageSize,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.totalPages,
  });

  factory MyTripsPaginated.fromJson(Map<String, dynamic> json) {
    return MyTripsPaginated(
      items: (json['items'] as List).map((i) => Viaje.fromJson(i)).toList(),
      total: json['total'],
      current: json['current'],
      pageSize: json['pageSize'],
      hasNextPage: json['hasNextPage'],
      hasPreviousPage: json['hasPreviousPage'],
      totalPages: json['totalPages'],
    );
  }
}

class Viaje {
  final int id;
  final String? fechaFinalizacion;
  final String? duracion;
  final String estado;
  final int? bicicletaId;
  final int? usuarioId;
  final int? administradorInicioId;
  final int? administradorFinalId;
  final String fechaInicio;
  final String updatedAt;
  final String estacionInicioNombre; // Nuevo campo
  final String? estacionFinalNombre; // Nuevo campo

  Viaje({
    required this.id,
    this.fechaFinalizacion,
    this.duracion,
    required this.estado,
    required this.bicicletaId,
    required this.usuarioId,
    required this.administradorInicioId,
    this.administradorFinalId,
    required this.fechaInicio,
    required this.updatedAt,
    required this.estacionInicioNombre, // Nuevo campo
    this.estacionFinalNombre,
  });

  factory Viaje.fromJson(Map<String, dynamic> json) {
    return Viaje(
      id: json['id'],
      fechaFinalizacion: json['fecha_finalizacion'],
      duracion: json['duracion']?.toString(),
      estado: json['estado'],
      bicicletaId: json['bicicleta_id'] ?? 0,
      usuarioId: json['usuario_id'] ?? 0,
      administradorInicioId: json['administrador_inicio_id'] ?? 0,
      administradorFinalId: json['administrador_final_id'] ,
      fechaInicio: json['fecha_inicio'],
      updatedAt: json['updated_at'],
      estacionInicioNombre: json['estacion_inicio']
          ['nombre'], // Asignación del nuevo campo
      estacionFinalNombre: json['estacion_final']?['nombre'],
    );
  }
}
