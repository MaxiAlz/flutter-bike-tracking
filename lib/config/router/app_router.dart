import 'package:app_ciudadano_vc/feactures/auth/presentation/screens/auth_screen.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/screens/enter_code_scree.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/screens/welcome_screen.dart';
import 'package:app_ciudadano_vc/feactures/home/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/welcome', routes: [
  ///* Auth Routes
  GoRoute(
    path: '/welcome',
    builder: (context, state) => const WelcomeScreen(),
  ),
  GoRoute(
    path: '/auth',
    builder: (context, state) => const AuthScreen(),
  ),

  /// Home Routes
  GoRoute(
    path: '/home',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/enter-code',
    builder: (context, state) => const EnterCodeScreen(),
  )
]);
