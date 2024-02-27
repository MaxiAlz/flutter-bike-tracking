import 'package:app_ciudadano_vc/feactures/auth/presentation/auth_presentation.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/register', routes: [
  ///* Auth Routes
  GoRoute(
    path: '/welcome',
    builder: (context, state) => const WelcomeScreen(),
  ),

  GoRoute(
    path: '/auth',
    builder: (context, state) => const AuthScreen(),
  ),

  GoRoute(
    path: '/register',
    builder: (context, state) => const RegisterScreen(),
  ),

  GoRoute(
    path: '/enter-code',
    builder: (context, state) => const EnterCodeScreen(),
  ),

  /// Home Routes
  GoRoute(
    path: '/home',
    builder: (context, state) => const HomeScreen(),
  ),
]);
