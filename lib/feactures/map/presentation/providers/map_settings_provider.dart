import 'package:app_ciudadano_vc/shared/infraestructure/services/geolocation/geolocation_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final mapSettingProvider =
    StateNotifierProvider<MapSettingNotifier, MapSettingState>((ref) {
  return MapSettingNotifier();
});

final position = Position(
    longitude: 0,
    latitude: 0,
    timestamp: DateTime(0),
    accuracy: 0,
    altitude: 0,
    altitudeAccuracy: 0,
    heading: 0,
    headingAccuracy: 0,
    speed: 0,
    speedAccuracy: 0);

class MapSettingState {
  final Position userPosition;
  final bool isLocationServiceEnabled;

  MapSettingState({
    required this.userPosition,
    this.isLocationServiceEnabled = false,
  });

  MapSettingState copyWith({
    Position? userPosition,
    bool? isLocationServiceEnabled,
  }) {
    return MapSettingState(
      userPosition: userPosition ?? this.userPosition,
      isLocationServiceEnabled:
          isLocationServiceEnabled ?? this.isLocationServiceEnabled,
    );
  }
}

class MapSettingNotifier extends StateNotifier<MapSettingState> {
  MapSettingNotifier() : super(MapSettingState(userPosition: position));

  Future<void> updateLocation() async {
    print('coso');
    final Position position = await GeolocationImpl().determinePosition();
    state = state.copyWith(userPosition: position);
  }

  Future getUserPosition() async {
    return await GeolocationImpl().getCurrentLocation();
  }

  // Future<void> checkPermission() async {
  //   final permissions = await GeolocationImpl().checkPermission();
  //   print(permissions);
  //   return;
  //   // state = state.copyWith(isLocationServiceEnabled:permissions);
  // }
}
