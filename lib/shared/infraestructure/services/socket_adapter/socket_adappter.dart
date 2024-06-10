import 'package:app_ciudadano_vc/config/constants/enviroments.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

class SocketService {
  final String channel;
  socket_io.Socket? socket;
  Function(Map<String, dynamic>)? onStatusReceived;

  SocketService({
    required this.channel,
    this.onStatusReceived,
  });

  void initialize() {
    socket = socket_io.io(Enviroments.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket!.connect();

    socket!.on('connect', (_) {
      print('Conectado');
      socket!.emit('join', channel);
    });

    socket!.on('disconnect', (_) {
      print('Desconectado');
    });

    socket!.on(channel, (data) {
      print('Mensaje recibido: $data');
      if (onStatusReceived != null) {
        onStatusReceived!(data);
      }
      // Aquí puedes agregar la lógica para manejar los datos recibidos
    });

    socket!.on('connect_error', (error) {
      print('Error de conexión: $error');
    });

    socket!.on('reconnect_attempt', (_) {
      print('Intentando reconectar...');
      socket!.io.options?['transports'] = ['websocket'];
    });
  }

  void sendMessage(String message) {
    if (socket != null && socket!.connected) {
      socket!.emit(channel, message);
    }
  }

  void dispose() {
    socket?.close();
  }
}
