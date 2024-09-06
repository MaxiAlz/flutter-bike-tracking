import 'package:app_ciudadano_vc/config/constants/app_constants.dart';
import 'package:app_ciudadano_vc/feactures/trips/insfraestructure/service/trip_services.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/services/socket_adapter/socket_adappter.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/share_infraestructure.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TripStatus { pending, inProgress, notTravelling, failed, finished, denied }

TripStatus _mapEstadoToTripStatus(String estado) {
  switch (estado) {
    case 'PENDIENTE':
      return TripStatus.pending;
    case 'EN_VIAJE':
      return TripStatus.inProgress;
    case 'FINALIZADO':
      return TripStatus.finished;
    case 'RECHAZADO':
      return TripStatus.denied;
    default:
      return TripStatus.failed;
  }
}

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
  final String errorMessage;

  TripState({
    this.tripData,
    this.tripStatus = TripStatus.notTravelling,
    this.isTripInProgress = false,
    this.startTime = '',
    this.errorMessage = '',
  });

  TripState copyWith(
      {TripStatus? tripStatus,
      bool? isTripInProgress,
      TripData? tripData,
      String? startTime,
      String? errorMessage}) {
    return TripState(
      tripStatus: tripStatus ?? this.tripStatus,
      isTripInProgress: isTripInProgress ?? this.isTripInProgress,
      tripData: tripData ?? this.tripData,
      startTime: startTime ?? this.startTime,
      errorMessage: errorMessage ?? this.errorMessage,
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

  Future requestFailed(
      {required TripStatus tripstatus, required String errorMessage}) async {
    state = state.copyWith(tripStatus: tripstatus, errorMessage: errorMessage);
  }

  Future setTripData(
      {required String estadoViaje, required int viajeId}) async {
    state = state.copyWith(
      tripData: TripData(estado: estadoViaje, viajeId: viajeId),
      tripStatus: _mapEstadoToTripStatus(estadoViaje),
    );
  }

  Future sendTripRequest(
      {required String trackerCodigo, required int userId}) async {
    try {
      final serviceResponse = await tripServices.sendTravelRequestService(
        trackerCodigo: trackerCodigo,
        userId: userId,
      );

      if (serviceResponse?.statusCode == 201) {
        // final startTime = DateTime.now().millisecondsSinceEpoch;
        final viajeId = serviceResponse.data['id'];
        final estadoViaje = serviceResponse?.data["estado"];
        final socketChanelTrip = 'appViaje/$viajeId';

        state = state.copyWith(
          tripData: TripData(estado: estadoViaje, viajeId: viajeId),
          tripStatus: _mapEstadoToTripStatus(estadoViaje),
        );

        initializeSocket(channel: socketChanelTrip);

        return serviceResponse;
      }

      if (serviceResponse.statusCode == 400) {
        state = state.copyWith(
            tripStatus: TripStatus.failed, isTripInProgress: false);
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

  void initializeSocket({required String channel}) {
    socket?.dispose();
    socket = SocketService(channel: channel);
    socket!.initialize();
    socket!.onStatusReceived = _handleSocketMessage;
  }

  void _handleSocketMessage(Map<String, dynamic> data) async {
    final estado = data['estado'];
    final tripStatus = _mapEstadoToTripStatus(estado);

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
