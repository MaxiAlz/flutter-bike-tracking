import 'package:app_ciudadano_vc/shared/infraestructure/services/geolocation/geolocation_service.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationImpl extends GeolocationService {
  @override
  Future<LocationPermission> checkPermission() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    return permission;
  }

  @override
  Future<Position> getCurrentLocation() async {
    final Position currentLocation = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    return currentLocation;
  }

  @override
  Future<Position?> getLastKnownPosition() async {
    return await Geolocator.getLastKnownPosition();
  }

  @override
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      print(' =>Location services are disabled.');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return await Geolocator.getCurrentPosition();
  }

  @override
  Stream<bool> getServiceStatusStream() {
    return Geolocator.getServiceStatusStream()
        .map((event) => event == ServiceStatus.enabled);
  }
}
