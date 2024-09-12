import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroments {
  static initEnviroment() async {
    await dotenv.load(fileName: ".env");
  }

  static String apiUrl = dotenv.env['API_URL'] ?? 'No hay apiUrl';
  static String apiUrlUpdate =
      dotenv.env['API_UPLOAD_URL'] ?? 'No hay apiUrlUpdate';
  static String socketUrl = dotenv.env['SOCKET_CHANEL'] ?? 'No hay socket url';
  static String wathsAppNumber =
      dotenv.env['WHATSAPP_NUMBER'] ?? 'No hay WhatsApp';
}
