import 'package:app_ciudadano_vc/feactures/trips/insfraestructure/service/trip_services.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/services/socket_adapter/socket_adappter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TripStatus { pending, inProgress, notTravelling, failed, finished }

class TipData {
  final int viajeId;
  final String estado;

  TipData({this.viajeId = 1, this.estado = ""});
}

// Proveedor de estado del viaje
final tripNotifierProvider =
    StateNotifierProvider<TripNotifier, TripState>((ref) {
  final tripServices = TripServices();
  final socketService = SocketService(channel: 'appViaje');
  return TripNotifier(tripServices: tripServices, socket: socketService);
});

class TripState {
  final TripStatus tripStatus;
  final bool isTripInProgress;
  final TipData? tripData;

  TripState({
    this.tripData,
    this.tripStatus = TripStatus.notTravelling,
    this.isTripInProgress = false,
  });

  TripState copyWith(
      {TripStatus? tripStatus, bool? isTripInProgress, TipData? tripData}) {
    return TripState(
        tripStatus: tripStatus ?? this.tripStatus,
        isTripInProgress: isTripInProgress ?? this.isTripInProgress,
        tripData: tripData ?? this.tripData);
  }
}

// Definición de TripNotifier
class TripNotifier extends StateNotifier<TripState> {
  final TripServices tripServices;
  final SocketService socket;

  TripNotifier({required this.tripServices, required this.socket})
      : super(TripState()) {
    socket.initialize();
    socket.onStatusReceived = _handleSocketMessage;
  }

  Future sendTripRequest({required String lockId, required int userId}) async {
    state = state.copyWith(tripStatus: TripStatus.pending);

    try {
      final serviceResponse = await tripServices.sendTravelRequestService(
          lockId: lockId, userId: userId);

      if (serviceResponse?.statusCode == 201) {
        state = state.copyWith(
            tripData: TipData(
                estado: serviceResponse?.data["estado"],
                viajeId: serviceResponse?.data["viaje_id"]));

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

  void _handleSocketMessage(Map<String, dynamic> data) {
    final estado = data['estado'];

    if (estado == 'PENDIENTE') {
      state = state.copyWith(tripStatus: TripStatus.pending);
      return;
    }
    if (estado == 'EN_VIAJE') {
      state = state.copyWith(
          tripStatus: TripStatus.inProgress, isTripInProgress: true);
      return;
    }
    if (estado == 'FINALIZADO') {
      state = state.copyWith(
          tripStatus: TripStatus.finished, isTripInProgress: false);
      return;
    }
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }
}
