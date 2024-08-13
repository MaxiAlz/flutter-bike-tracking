import 'package:app_ciudadano_vc/config/config.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_provider.dart';
import 'package:app_ciudadano_vc/feactures/home/presentation/home_presentation.dart';
import 'package:app_ciudadano_vc/feactures/map/presentation/map_presentation.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/services/permissions_handler/permissions_provider.dart';
import 'package:app_ciudadano_vc/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import 'package:app_ciudadano_vc/feactures/trips/presentation/providers/trip_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final userDataAuthenticated = ref.watch(authProvider).user;
    // final tripProvider = ref.read(tripNotifierProvider.notifier);
    // final router = ref.read(goRouterProvider);
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final systemPermisionProvier = ref.watch(permissionsAppProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      // Para quitar el appbar y que se vea el mapa toda la pantalla
      // Expanded((child: _HomeView())
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
      ),
      body: SafeArea(
          // child: CheckPermissionsView(),
          child: systemPermisionProvier.isGpsPermissionGranted &&
                  systemPermisionProvier.isGpsEnabled
              ? const _HomeView()
              : _CheckPermissionsView()),
    );
  }
}

class _CheckPermissionsView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final systemPermisionProvier = ref.watch(permissionsAppProvider);
    final titlesStyle = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  'Oops! :(',
                  style: titlesStyle.titleLarge,
                ),
              ),
            ),
            Center(
              child: Text(
                'Debe activar sus permisos de ubicacion.',
                style: titlesStyle.titleMedium,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: SvgPicture.asset(
              'assets/svg/undraw_my_location_re_r52x.svg',
              width: 350.0,
            ),
          ),
        ),
        Text(
          'Localizacion:  ${systemPermisionProvier.isGpsEnabled ? 'Activada' : 'Desactivada'}',
        ),
        Text(
          'Permisos de localizacion:  ${systemPermisionProvier.isGpsPermissionGranted ? 'Habilitados' : 'Deshabilitados'}',
        ),
        const SizedBox(
          height: 10,
        ),
        !systemPermisionProvier.isGpsPermissionGranted
            ? FilledButton(
                onPressed: () {
                  ref.read(permissionsAppProvider.notifier).checkGpsStatus();
                },
                child: const Text('Activar permisos manualmente'))
            : const SizedBox(),
      ],
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
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
