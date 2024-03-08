import 'package:app_ciudadano_vc/shared/infraestructure/services/geolocation/geolocation_service.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationImpl extends GeolocationService {
  @override
  Future<Position> checkPermission() {
    // TODO: implement checkPermission
    throw UnimplementedError();
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
