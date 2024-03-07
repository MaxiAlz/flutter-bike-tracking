import 'package:app_ciudadano_vc/shared/widgets/buttons/custom_center_floating_action.dart';
import 'package:app_ciudadano_vc/shared/widgets/drawer/side_menu_drawer.dart';
import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).colorScheme;
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        body: const SafeArea(child: _HomeView()),
        appBar: AppBar(
          title: const Text(
            '¡Hola, Usuario!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
          ],
        ),
        // floatingActionButton: Icon(Icons.menu_book_outlined),
        drawer: SideMenuDrawer(
          scaffoldKey: scaffoldKey,
        ));
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    // final diviceData = MediaQuery.of(context);
    return Stack(children: [
      // Container(
      //   alignment: Alignment.center,
      //   child: const Text('Home screen'),
      // ),
      FlutterMap(
        mapController: MapController(),
        options: const MapOptions(
          initialZoom: 10,
          initialCenter: LatLng(-28.460501, -65.780756),

          // initialCameraFit: CameraFit.coordinates(coordinates: )
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            // Plenty of other options available!
          ),
        ],
      ),

      Container(
        alignment: Alignment.bottomCenter,
        child: const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 35),
          child: _ScanCodeButton(),
        ),
      ),
    ]);
  }
}

class _ScanCodeButton extends StatelessWidget {
  const _ScanCodeButton();

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).colorScheme;
    return CustomCenterFloatingActionButton(
      icon: Icons.qr_code_scanner_outlined,
      onPressed: () {},
    );
  }
}
