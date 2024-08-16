import 'package:app_ciudadano_vc/config/config.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_provider.dart';
import 'package:app_ciudadano_vc/feactures/home/presentation/home_presentation.dart';
import 'package:app_ciudadano_vc/feactures/trips/presentation/providers/trip_provider.dart';
import 'package:app_ciudadano_vc/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final userDataAuthenticated = ref.watch(authProvider).user;
    final tripProvider = ref.read(tripNotifierProvider.notifier);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    checkIfTripInProgress() async {
      if (userDataAuthenticated?.tripData != null) {
        final tripAsyncData = userDataAuthenticated!.tripData;
        final socketChanelTrip = 'appViaje/${tripAsyncData!.id}';
        await tripProvider.setTripData(
            estadoViaje: tripAsyncData.estado, viajeId: tripAsyncData.id);
        tripProvider.initializeSocket(channel: socketChanelTrip);
        ref.read(goRouterProvider).go('/trip-trackin');
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      checkIfTripInProgress();
    });

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
      body: const SafeArea(
        child: HomeView(),
      ),
    );
  }
}



 // child: systemPermisionProvier.isGpsPermissionGranted &&
        //         systemPermisionProvier.isGpsEnabled
        //     ? const HomeView()
        //     : const CheckPermissionsView(),