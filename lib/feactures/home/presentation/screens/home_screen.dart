import 'package:app_ciudadano_vc/shared/widgets/drawer/side_menu_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).colorScheme;
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        body: _HomeView(),
        appBar: AppBar(
          title: const Text(
            '¡Hola, Usuario!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
          ],
        ),

        // floatingActionButton: Icon(Icons.menu_book_outlined),
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
    return Center(
      child: Text('Home screen'),
    );
  }
}
