import 'package:app_ciudadano_vc/shared/infraestructure/services/geolocation/geolocation_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final permissionsAppProvider =
    StateNotifierProvider<PermissionsNotifier, PermissionsState>((ref) {
  final geolocatorService = GeolocationImpl();
  return PermissionsNotifier(geolocatorService: geolocatorService);
});

// Estados del provider
class PermissionsState {
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

  PermissionsState({
    required this.isGpsEnabled,
    required this.isGpsPermissionGranted,
  });

  PermissionsState copyWith({
    bool? isGpsEnabled,
    bool? isGpsPermissionGranted,
  }) {
    return PermissionsState(
      isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled,
      isGpsPermissionGranted:
          isGpsPermissionGranted ?? this.isGpsPermissionGranted,
    );
  }
}

// Metodos y funciones del provider
class PermissionsNotifier extends StateNotifier<PermissionsState> {
  final GeolocationImpl geolocatorService;

  PermissionsNotifier({required this.geolocatorService})
      : super(PermissionsState(
          isGpsEnabled: false,
          isGpsPermissionGranted: false,
        )) {
    // Metodos que se inicializan en el constructor
    _initStream();
  }

  void updateGpsPermissionStatus(
      {bool? isGpsEnabled, bool? isGpsPermissionGranted}) {
    state = state.copyWith(
      isGpsEnabled: isGpsEnabled,
      isGpsPermissionGranted: isGpsPermissionGranted,
    );
  }

  Future<void> _initStream() async {
    _checkGpsStatus();
    // Escuchar los cambios en el estado del servicio de ubicación
    geolocatorService.getServiceStatusStream().listen((isEnabled) {
      updateGpsPermissionStatus(isGpsEnabled: isEnabled);
    });
  }

  Future<void> _checkGpsStatus() async {
    final isEnable = await geolocatorService.isLocationServiceEnabled();
    final permissionStatus = await geolocatorService.checkPermission();
    final isPermissionGranted =
        permissionStatus == LocationPermission.whileInUse ||
            permissionStatus == LocationPermission.always;
    updateGpsPermissionStatus(
      isGpsEnabled: isEnable,
      isGpsPermissionGranted: isPermissionGranted,
    );
  }

  @override
  String toString() =>
      'isGpsEnabled: ${state.isGpsEnabled}, isGpsPermissionGranted:${state.isGpsPermissionGranted}';
}
