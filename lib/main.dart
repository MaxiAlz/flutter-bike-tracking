import 'package:app_ciudadano_vc/config/config.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_form_provider.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:shared_preferences/shared_preferences.dart';
Future<void> limpiarSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs
      .clear(); // Limpia todas las variables guardadas en SharedPreferences
}

void main() async {
  await Enviroments.initEnviroment();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    limpiarSharedPreferences();
    final appRouterProvider = ref.watch(goRouterProvider);

    final authprovider = ref.watch(authProvider);
    final formprovider = ref.watch(authFormProvider);

    print('''

appRouterProvider: $appRouterProvider
authprovider: $authprovider
formprovider: $formprovider

''');

    return MaterialApp.router(
      routerConfig: appRouterProvider,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}
