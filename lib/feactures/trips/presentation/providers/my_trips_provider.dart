import 'package:app_ciudadano_vc/feactures/trips/domain/entities/viaje_entity.dart';
import 'package:app_ciudadano_vc/feactures/trips/insfraestructure/service/trip_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tripService = TripServices();

final myTripProvider = FutureProvider<MyTripsPaginated>((ref) async {
  return tripService.getMyTrips();
});
