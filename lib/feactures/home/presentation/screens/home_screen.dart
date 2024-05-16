import 'package:app_ciudadano_vc/config/config.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_provider.dart';
import 'package:app_ciudadano_vc/feactures/home/presentation/home_presentation.dart';
import 'package:app_ciudadano_vc/feactures/map/presentation/map_presentation.dart';
import 'package:app_ciudadano_vc/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final userDataAuthenticated = ref.watch(authProvider).user;

    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: const SafeArea(child: _HomeView()),
        appBar: AppBar(
          backgroundColor: colors.primary,
          iconTheme: IconThemeData(color: Colors.amber.shade300),
          elevation: 0,
          centerTitle: true,
          title: Row(children: [
            Text(
              '¡Hola',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 25,
                color: colors.surface,
              ),
            ),
            Text(
              ', ${userDataAuthenticated?.name.toUpperCase()}!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: colors.surface,
                fontSize: 25,
              ),
            ),
          ]),
          actions: [
            IconButton(
                onPressed: () {
                  ref.read(goRouterProvider).push('/notifications');
                },
                icon: const Icon(Icons.notifications))
          ],
        ),
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
      const CustomGradient(
        bottom: 0,
        top: 700,
        left: 0,
        right: 0,
        width: 10,
        height: 10,
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ),
      Container(
        alignment: Alignment.bottomLeft,
        child: Image.asset(
          'assets/images/vamos-en-bici-01.png',
          width: 150,
        ),
      ),
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
