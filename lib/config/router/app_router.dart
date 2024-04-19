import 'package:app_ciudadano_vc/config/router/app_router_notifier.dart';
import 'package:app_ciudadano_vc/feactures/auth/domain/entities/auth_status.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/auth_presentation.dart';
import 'package:app_ciudadano_vc/feactures/notifications/notifications.dart';
import 'package:app_ciudadano_vc/feactures/trips/trips.dart';
import 'package:app_ciudadano_vc/feactures/user/user_settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/*
Enviar a otra pantalla con provider
ref.read(goRouterProvider).push('/register');
 */

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/checking-status',
    refreshListenable: goRouterNotifier,
    routes: [
      ///* Auth Routes
      GoRoute(
        path: '/checking-status',
        builder: (context, state) => const CheckAuthStatus(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/waiting-validation',
        builder: (context, state) => const WaitingValidation(),
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
        path: '/file-register',
        builder: (context, state) => const UploadFiles(),
      ),

      GoRoute(
        path: '/enter-code',
        builder: (context, state) => const EnterCodeScreen(),
      ),

      /// Home Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/my-account',
        builder: (context, state) => const UserProfile(),
      ),
      GoRoute(
        path: '/my-trips',
        builder: (context, state) => const MyTripsSCreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      if (isGoingTo == '/checking-status' &&
          authStatus == AuthStatus.checking) {
        return null;
      }

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/auth' ||
            isGoingTo == '/register' ||
            isGoingTo == '/enter-code' ||
            isGoingTo == '/welcome') return null;
        return '/welcome';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/auth' ||
            isGoingTo == '/register' ||
            isGoingTo == '/enter-code' ||
            isGoingTo == '/welcome' ||
            isGoingTo == '/checking-status') {
          return '/';
        }
        return null;
      }

      return null;
    },
  );
});
