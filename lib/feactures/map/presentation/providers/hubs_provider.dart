import 'package:app_ciudadano_vc/feactures/map/domain/entities/hub_entiti.dart';
import 'package:app_ciudadano_vc/feactures/map/insfraestructure/services/hubs_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hubServices = HubServices();

final hubListProvider = FutureProvider<List<Hub>>((ref) async {
  try {
    final apiResponse = await hubServices.getAvailableHubs();

    return apiResponse;
  } catch (error) {
    throw Error();
  }
});
