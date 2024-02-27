import 'package:app_ciudadano_vc/shared/widgets/buttons/custom_center_floating_action.dart';
import 'package:app_ciudadano_vc/shared/widgets/drawer/side_menu_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).colorScheme;
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        body: const _HomeView(),
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
      Container(
        alignment: Alignment.center,
        child: const Text('Home screen'),
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
