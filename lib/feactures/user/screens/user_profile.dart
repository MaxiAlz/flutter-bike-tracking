import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_provider.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/masks/input_masks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    // final scaffoldKey = GlobalKey<ScaffoldState>();
    final colors = Theme.of(context).colorScheme;
    final subtitlesStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      body: const _UserInformation(),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Color blanco para el icono de retroceso
        ),
        centerTitle: true,
        backgroundColor: colors.primary,
        title: Text(
          'Mi cuenta',
          style: subtitlesStyle!.copyWith(fontSize: 18, color: Colors.white),
        ),
      ),
      // drawer: SideMenuDrawer(scaffoldKey: scaffoldKey)
    );
  }
}

class _UserInformation extends ConsumerWidget {
  const _UserInformation();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(authProvider).user;
    final subtitlesStyle = Theme.of(context).textTheme.titleMedium;
    final colors = Theme.of(context).colorScheme;

    final mask = InputMaskFormated();

// userdata.
    return SingleChildScrollView(
      // padding: EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                // color: Colors.white,
                color: colors.primary,

                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 8.0,
                    spreadRadius: 2.0,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(userData?.photo ??
                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${userData?.name.toUpperCase()} ${userData?.lastName.toUpperCase()}',
                    style: subtitlesStyle!.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      '${userData?.email} ',
                    ),
                    leading: const Icon(Icons.email_outlined),
                    subtitle: const Text('Email'),
                    // trailing: Text('Email'),
                  ),
                  const Divider(),
                  ListTile(
                    title: Text(mask.applyMask(
                        value: userData?.phoneNumber as String,
                        maskType: MaskType.phoneNumberMask)),
                    leading: const Icon(Icons.phone_iphone_sharp),
                    subtitle: const Text('Telefono'),
                  ),
                  const Divider(),
                  ListTile(
                    title: Text(
                      '${userData?.dateOfBirth} ',
                    ),
                    leading: const Icon(Icons.date_range_outlined),
                    subtitle: const Text('Fecha de nacimiento'),
                  ),
                  const Divider(),
                  ListTile(
                    title: Text(
                      '${userData?.gender} ',
                    ),
                    leading: const Icon(Icons.boy_outlined),
                    subtitle: const Text('Genero'),
                  ),
                  const Divider(),
                ],
              ),
            ),
            // GlassmorphicContainer(),
            OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.edit_outlined),
                label: Text('Editar perfil'))
          ],
        ),
      ),
    );
  }
}
