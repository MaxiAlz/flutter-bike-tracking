import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_provider.dart';
import 'package:app_ciudadano_vc/shared/widgets/drawer/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SideMenuDrawer extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const SideMenuDrawer({super.key, required this.scaffoldKey});

  @override
  State<SideMenuDrawer> createState() => _SideMenuDrawerState();
}

class _SideMenuDrawerState extends State<SideMenuDrawer> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: NavigationDrawer(
              onDestinationSelected: (value) {
                setState(() {
                  navDrawerIndex = value;
                  final menuItem = appMenuItems[value];
                  context.push(menuItem.link);
                  widget.scaffoldKey.currentState?.closeDrawer();
                });
              },
              selectedIndex: navDrawerIndex,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(28, hasNotch ? 10 : 25, 16, 10),
                  child: const _TopIcons(),
                ),
                ...appMenuItems.sublist(0, 3).map((menuItem) =>
                    NavigationDrawerDestination(
                        icon: Icon(menuItem.icon),
                        label: Text(menuItem.title))),
                const Padding(
                  padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
                  child: Divider(),
                ),
                ...appMenuItems.sublist(3).map((menuItem) =>
                    NavigationDrawerDestination(
                        icon: Icon(menuItem.icon),
                        label: Text(menuItem.title))),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const _LogoutButton(),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Divider(),
          ),
          SizedBox(
            width: 10,
            height: 100,
            child: Image.asset(
              'assets/images/capital-sustentable.png',
              fit: BoxFit.cover, // Ajustar la imagen dentro del contenedor
            ),
          )
        ],
      ),
    );
  }
}

class _LogoutButton extends ConsumerWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton.icon(
        onPressed: () {
          ref.read(authProvider.notifier).logoutUSer();
          context.push('/welcome');
        },
        icon: const Icon(Icons.close),
        label: const Text('Cerrar sesion'));
  }
}

class _TopIcons extends StatelessWidget {
  const _TopIcons();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Image.asset(
      'assets/images/vamos-en-bici-01.png',
      width: 100,
    ));
  }
}
