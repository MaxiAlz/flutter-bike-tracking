import 'package:app_ciudadano_vc/feactures/trips/insfraestructure/service/trip_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TripStatus {
  pending,
  inProgress,
  notTravelling,
  failed,
}

final tripNotifierProvider =
    StateNotifierProvider<TripNotifier, TripState>((ref) {
  final tripServices = TripServices();
  return TripNotifier(tripServices: tripServices);
});

class TripState {
  final TripStatus tripStatus;
  final bool isTripInProgress;

  TripState(
      {this.tripStatus = TripStatus.notTravelling,
      this.isTripInProgress = false});

  TripState copyWith({
    TripStatus? tripStatus,
    bool? isTripInProgress,
  }) {
    return TripState(
      tripStatus: tripStatus ?? this.tripStatus,
      isTripInProgress: isTripInProgress ?? this.isTripInProgress,
    );
  }
}

// Definición de TripNotifier
class TripNotifier extends StateNotifier<TripState> {
  final TripServices tripServices;
  TripNotifier({required this.tripServices}) : super(TripState());

  Future sendTripRequest({required String lockId, required int userId}) async {
    state = state.copyWith(tripStatus: TripStatus.pending);

    try {
      final serviceResponse = await tripServices.sendTravelRequestService(
          lockId: lockId, userId: userId);

      if (serviceResponse?.statusCode == 201) {
        state = state.copyWith(
            tripStatus: TripStatus.pending, isTripInProgress: true);
        return serviceResponse;
      }

      if (serviceResponse.statusCode == 404) {
        state = state.copyWith(
            tripStatus: TripStatus.failed, isTripInProgress: false);
        return serviceResponse;
      }

      return serviceResponse;
    } on DioException catch (error) {
      return error;
    }
  }

  // void startTrip() {
  //   state =
  //       state.copyWith(tripStatus: TripStatus.pending, isTripInProgress: true);
  // }
}
