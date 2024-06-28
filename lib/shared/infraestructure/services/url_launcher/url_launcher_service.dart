import 'package:app_ciudadano_vc/config/config.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchWspService {
  static Future<void> _sendMessage({required String message}) async {
    final phoneNumber = Enviroments.wathsAppNumber;
    final whatsappUrl = Uri.parse(
        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}");

    if (!await launchUrl(whatsappUrl)) {
      throw Exception('Could not launch $whatsappUrl');
    }
  }

  Future<void> launchWhatsApp({
    required String message,
    required BuildContext context,
  }) async {
    try {
      await _sendMessage(
        message: message,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo abrir WhatsApp'),
        ),
      );
    }
  }
}


// uso en el boton

// onPressed: () => _launchWhatsApp(userName, phoneNumber),

// Future<void> _launchWhatsApp(String userName, String phoneNumber) async {
//     try {
//       await WhatsAppService.sendMessage(
//         userName: userName,
//         phoneNumber: phoneNumber,
//       );
//     } catch (e) {
//       // Manejo del error si no se pudo abrir WhatsApp
//       print(e.toString());
//     }
//   }
// }