import 'dart:async';

import 'package:app_ciudadano_vc/shared/infraestructure/services/geolocation/geolocation_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final mapSettingProvider =
    StateNotifierProvider<MapSettingNotifier, MapSettingState>((ref) {
  return MapSettingNotifier();
});

final initialPosition = Position(
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
  // final bool isLocationServiceEnabled;
  final bool isLoadingPositions;

  MapSettingState({
    this.isLoadingPositions = false,
    required this.userPosition,
    // this.isLocationServiceEnabled = false,
  });

  MapSettingState copyWith({
    Position? userPosition,
    bool? isLocationServiceEnabled,
    bool? isLoadingPositions,
  }) {
    return MapSettingState(
      userPosition: userPosition ?? this.userPosition,
      isLoadingPositions: isLoadingPositions ?? this.isLoadingPositions,
      // isLocationServiceEnabled:
      //     isLocationServiceEnabled ?? this.isLocationServiceEnabled,
    );
  }
}

class MapSettingNotifier extends StateNotifier<MapSettingState> {
  StreamSubscription<Position>? _positionStreamSubscription;

  MapSettingNotifier() : super(MapSettingState(userPosition: initialPosition)) {
    _initialize();
  }

  Future<void> updateLocation() async {
    final Position position = await GeolocationImpl().determinePosition();
    state = state.copyWith(userPosition: position);
  }

  Future<void> _initialize() async {
    await getUserPosition();
    _startTracking();
  }

  void _startTracking() {
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      state = state.copyWith(userPosition: position);
    });
  }

  Future getUserPosition() async {
    state = state.copyWith(isLoadingPositions: true);
    try {
      final userPosition = await GeolocationImpl().getCurrentLocation();
      state =
          state.copyWith(userPosition: userPosition, isLoadingPositions: false);
      return userPosition;
    } catch (e) {
      state = state.copyWith(isLoadingPositions: false);
      // Manejar error
    }
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }
}
