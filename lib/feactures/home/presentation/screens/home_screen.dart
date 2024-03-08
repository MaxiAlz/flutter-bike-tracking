import 'package:app_ciudadano_vc/feactures/home/presentation/home_presentation.dart';
import 'package:app_ciudadano_vc/feactures/map/presentation/map_presentation.dart';
import 'package:app_ciudadano_vc/shared/widgets/drawer/side_menu_drawer.dart';
import 'package:flutter/material.dart';

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
      const MapViewLayer(),
      Container(
        alignment: Alignment.bottomCenter,
        child: const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 35),
          child: ScanCodeButton(),
        ),
      ),
    ]);
  }
}
