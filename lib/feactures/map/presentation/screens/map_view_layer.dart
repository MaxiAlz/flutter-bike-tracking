import 'package:app_ciudadano_vc/feactures/map/presentation/map_presentation.dart';
import 'package:app_ciudadano_vc/feactures/map/presentation/providers/hubs_provider.dart';
import 'package:app_ciudadano_vc/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapViewLayer extends ConsumerWidget {
  const MapViewLayer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final markerDialogHub = MarkerDialogHub();
    final mapController = MapController();
    final hubList = ref.watch(hubListProvider);

    return hubList.when(
      data: (listOfHubs) => MapView(
          mapController: mapController,
          hubList: hubList,
          markerDialogHub: markerDialogHub),
      loading: () {
        return const Center(
          child: FullLoader(
            label: 'Cargando mapa...',
          ),
        );
      },
      error: (error, stackTrace) {
        return const Center(
            child: Text(
                'Error al cargar la lista de estaciones, pruebe mas tarde'));
      },
    );
  }
}
