import 'package:app_ciudadano_vc/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';

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
    final appRouterProvider = ref.watch(goRouterProvider);

    return ToastificationWrapper(
      child: MaterialApp.router(
        routerConfig: appRouterProvider,
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
      ),
    );
  }
}
