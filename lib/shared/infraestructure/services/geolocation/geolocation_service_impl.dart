import 'package:app_ciudadano_vc/shared/infraestructure/services/geolocation/geolocation_service.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationImpl extends GeolocationService {
  @override
  Future<Position> checkPermission() async {
    dynamic permission = await Geolocator.checkPermission();
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
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }

  @override
  Future getLastKnownPosition() {
    // TODO: implement getLastKnownPosition
    throw UnimplementedError();
  }

  @override
  Future isLocationServiceEnabled() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    return serviceEnabled;
  }
}
