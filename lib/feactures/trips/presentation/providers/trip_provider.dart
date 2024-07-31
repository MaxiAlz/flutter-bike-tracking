import 'package:app_ciudadano_vc/config/constants/app_constants.dart';
import 'package:app_ciudadano_vc/feactures/auth/domain/auth_domain.dart';
import 'package:app_ciudadano_vc/feactures/trips/insfraestructure/service/trip_services.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/services/socket_adapter/socket_adappter.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/share_infraestructure.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TripStatus { pending, inProgress, notTravelling, failed, finished }

class TripData {
  final int viajeId;
  final String estado;

  TripData({this.viajeId = 1, this.estado = ""});
}

// Proveedor de estado del viaje
final tripNotifierProvider =
    StateNotifierProvider<TripNotifier, TripState>((ref) {
  final tripServices = TripServices();
  final internalStorage = KeyValueStorageImpl();
  final appConstants = AppConstants();

  return TripNotifier(
    tripServices: tripServices,
    internalStorage: internalStorage,
    appConstants: appConstants,
  );
});

class TripState {
  final TripStatus tripStatus;
  final bool isTripInProgress;
  final TripData? tripData;
  final String startTime;

  TripState({
    this.tripData,
    this.tripStatus = TripStatus.notTravelling,
    this.isTripInProgress = false,
    this.startTime = '',
  });

  TripState copyWith({
    TripStatus? tripStatus,
    bool? isTripInProgress,
    TripData? tripData,
    String? startTime,
  }) {
    return TripState(
      tripStatus: tripStatus ?? this.tripStatus,
      isTripInProgress: isTripInProgress ?? this.isTripInProgress,
      tripData: tripData ?? this.tripData,
      startTime: startTime ?? this.startTime,
    );
  }
}

// Definición de TripNotifier
class TripNotifier extends StateNotifier<TripState> {
  final TripServices tripServices;
  SocketService? socket;
  KeyValueStorageImpl internalStorage;
  AppConstants appConstants;

  TripNotifier({
    required this.tripServices,
    required this.internalStorage,
    required this.appConstants,
  }) : super(TripState());

  Future changeStatusToAnyState({required TripStatus tripstatus}) async {
    state = state.copyWith(tripStatus: tripstatus);
  }

  Future sendTripRequest({required String lockId, required int userId}) async {
   try {
      final serviceResponse = await tripServices.sendTravelRequestService(
        lockId: lockId,
        userId: userId,
      );
      // state = state.copyWith(tripStatus: TripStatus.pending);

      if (serviceResponse?.statusCode == 201) {
        // final startTime = DateTime.now().millisecondsSinceEpoch;
        final viajeId = serviceResponse.data['id'];
        final estadoViaje = serviceResponse?.data["estado"];
        final socketChanelTrip = 'appViaje/$viajeId';

        state = state.copyWith(
          tripData: TripData(estado: estadoViaje, viajeId: viajeId),
          tripStatus: _mapEstadoToTripStatus(estadoViaje),
        );

        _initializeSocket(channel: socketChanelTrip);

        return serviceResponse;
      }

      if (serviceResponse.statusCode == 400) {
        state = state.copyWith(
             tripStatus: TripStatus.inProgress, isTripInProgress: true);
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

  TripStatus _mapEstadoToTripStatus(String estado) {
    switch (estado) {
      case 'PENDIENTE':
        return TripStatus.pending;
      case 'EN_VIAJE':
        return TripStatus.inProgress;
      case 'FINALIZADO':
        return TripStatus.finished;
      default:
        return TripStatus.failed;
    }
  }

  // Future<void> _loadFromPrefs() async {
  //   // obtener estado de viaje de storage
  //   final tripStatusStorage =
  //       await internalStorage.getKeyValue(appConstants.tripStatusKey);
  //   // obtener valor de inicio de viaje
  //   final startTimeStorage =
  //       await internalStorage.getKeyValue(appConstants.timeStartTripkey);
  // }

  void _initializeSocket({required String channel}) {
    socket?.dispose();
    socket = SocketService(channel: channel);
    socket!.initialize();
    socket!.onStatusReceived = _handleSocketMessage;
  }

  void _handleSocketMessage(Map<String, dynamic> data) async {
    final estado = data['estado'];
    final tripStatus = _mapEstadoToTripStatus(estado);

    if (tripStatus == TripStatus.finished) {
      await internalStorage.removeKey(appConstants.socketChanelTrip);
    }

    state = state.copyWith(
        tripStatus: tripStatus,
        isTripInProgress: tripStatus == TripStatus.inProgress);
  }

  @override
  void dispose() {
    socket?.dispose();
    super.dispose();
  }
}
