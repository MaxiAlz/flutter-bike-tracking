import 'package:app_ciudadano_vc/config/router/app_router_notifier.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/auth_presentation.dart';
import 'package:app_ciudadano_vc/feactures/user/user_settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: /* '/checking-status' */ '/welcome',
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
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/my-account',
        builder: (context, state) => const UserProfile(),
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      print('''
=>> state: $state
=>> isGoingTo: $isGoingTo
=>> authStatus: $authStatus
''');

      // if (isGoingTo == '/checking-status' &&
      //     authStatus == AuthStatus.checking) {
      //   return null;
      // }

      // if (authStatus == AuthStatus.notAuthenticated) {
      //   if (isGoingTo == '/auth' || isGoingTo == '/register') return null;

      //   return '/auth';
      // }

      // if (authStatus == AuthStatus.authenticated) {
      //   // if (isGoingTo == '/my-account') return null;

      //   if (isGoingTo == '/auth' ||
      //           isGoingTo ==
      //               '/register' /* ||
      //       isGoingTo == '/checking-status' */
      //       ) {
      //     return '/home';
      //   }
      //   return null;
      // }

      return null;
    },
  );
});
