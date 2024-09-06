import 'package:app_ciudadano_vc/feactures/map/domain/entities/hub_entiti.dart';
import 'package:app_ciudadano_vc/feactures/map/insfraestructure/mappers/hub_mapper.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/services/http_adapter/http_adapter_impl.dart';

final api = Api();

class HubServices {
  Future<List<Hub>> getAvailableHubs() async {
    try {
      final apiResponse = await api.getHttp(path: '/estacion');

      if (apiResponse.statusCode == 200) {
        // Convertimos la respuesta JSON en una lista de hubs usando el método fromJson de la clase Hub
        final List<dynamic> hubDataList = apiResponse.data;
        final List<Hub> hubs =
            hubDataList.map((hubData) => HubMapper.fromJson(hubData)).toList();
        return hubs;
      } else {
        throw Exception('Failed to load hubs');
      }
    } catch (error) {
      // Manejar errores aquí si es necesario
      throw error;
    }
  }
}
