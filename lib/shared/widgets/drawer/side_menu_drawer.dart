import 'package:app_ciudadano_vc/config/menu_items.dart';
import 'package:flutter/material.dart';
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

    return NavigationDrawer(
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
            child: _TopIcons(),
          ),
          ...appMenuItems.sublist(0, 3).map((menuItem) =>
              NavigationDrawerDestination(
                  icon: Icon(menuItem.icon), label: Text(menuItem.title))),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
        ]);
  }
}

class _TopIcons extends StatelessWidget {
  const _TopIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Image.asset(
      'assets/images/vamos-en-bici-01.png',
      width: 100,
    ));
  }
}
