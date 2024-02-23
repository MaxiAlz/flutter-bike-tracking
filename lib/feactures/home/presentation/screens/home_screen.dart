import 'package:app_ciudadano_vc/shared/widgets/drawer/side_menu_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        body: _HomeView(),
        appBar: AppBar(
          
            // backgroundColor: Colors.blue,
            ),
        drawer: SideMenuDrawer(
          scaffoldKey: scaffoldKey,
        ));
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Text('adasdasd'),
      ),
    );
  }
}
