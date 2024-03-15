import 'package:latlong2/latlong.dart';

// final List<LatLng> marcadores = [
//   const LatLng(-28.476765, -65.787757),
//   const LatLng(-28.460397, -65.767009),
//   const LatLng(-28.469332, -65.779543),
//   const LatLng(-28.468513241372175, -65.7697717869181),
//   const LatLng(-28.49700522580078, -65.81606288858009),
// ];

class MarkerData {
  LatLng position;
  String title;
  String description;
  int availableBikes;

  MarkerData({
    required this.position,
    required this.title,
    required this.description,
    required this.availableBikes,
  });
}

final List<MarkerData> marcadoresData = [
  MarkerData(
    position: const LatLng(-28.476765, -65.787757),
    title: "Nodo Tecnologico",
    description: "Capital federal 172",
    availableBikes: 5,
  ),
  MarkerData(
    position: const LatLng(-28.460397, -65.767009),
    title: "Parque de los niños",
    description: "Av. Republica de venezuela",
    availableBikes: 3,
  ),
  MarkerData(
    position: const LatLng(-28.469332, -65.779543),
    title: "Plaza 25 de mayo",
    description: "Sarmiento 635-667",
    availableBikes: 8,
  ),
  MarkerData(
    position: const LatLng(-28.468513241372175, -65.7697717869181),
    title: "Isac",
    description: "San martin 1164",
    availableBikes: 2,
  ),
  MarkerData(
    position: const LatLng(-28.49700522580078, -65.81606288858009),
    title: "Punto giro - Valle chico",
    description: "Av. N° 2",
    availableBikes: 10,
  ),
];
