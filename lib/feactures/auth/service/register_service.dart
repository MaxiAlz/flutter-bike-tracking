import 'package:app_ciudadano_vc/config/config.dart';
import 'package:dio/dio.dart';

final Dio dio = Dio(BaseOptions(baseUrl: Enviroments.apiUrl));

class RegisterServices {
  Future registerUser({required files, required userData}) async {
    List<Map<String, dynamic>> responsesUrls = [];

    Map<String, dynamic> filteredFiles = {
      'photoDniBackPath': files.photoDniBackPath,
      'photoDniFrontPath': files.photoDniFrontPath,
      'photoUserPath': files.photoUserPath,
    };

    // Enviar archivos uno por uno
    for (String filePath in filteredFiles.values) {
      final response = await _uploadFile(filePath);
      responsesUrls.add(response.data);
    }

    // Ensamblar datos del usuario y las URLs de las fotos
    Map<String, dynamic> requestBody = {
      "nombre": userData.name,
      "apellido": userData.lastName,
      "fecha_nacimiento": userData.dateOfBirth,
      "numero_celular": userData.phoneNumberUnmasked,
      "documento_numero": userData.identificationNumberUnmasked,
      "foto": responsesUrls[0]['url'], // URL de la primera foto
      "documento_frontal": responsesUrls[1]['url'], // URL de la segunda foto
      "documento_dorsal": responsesUrls[2]['url'], // URL de la tercera foto
      "email": userData.email,
      "genero": userData.gender,
    };

    try {
      final response = await dio.post("/auth/registro", data: requestBody);

      return response;
    } catch (e) {
      Exception(e);
    }
  }

  Future _uploadFile(String filePath) async {
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(filePath, filename: "file"),
      });
      final response = await dio.post("/upload", data: formData);
      return response;
    } catch (e) {
      Exception(e);
    }
  }
}
