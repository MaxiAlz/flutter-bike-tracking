import 'package:app_ciudadano_vc/feactures/auth/domain/entities/auth_status.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
  Esta clase es para poder asignarle al Router un refreshListenable
 */
final goRouterNotifierProvider = Provider((ref) {
  final authNotifier = ref.read(authProvider.notifier);

  return GoRouterNofier(authNotifier);
});

// Permite poner un lstener en el router para
class GoRouterNofier extends ChangeNotifier {
  // instancia del AuthNotifier para checquear el estado
  final AuthNotifier _authNotifier;

// inicializacion del estado principal
  AuthStatus _authStatus = AuthStatus.checking;

// Constructor que esta pendiente de los estados, por eso el addListener
  GoRouterNofier(this._authNotifier) {
    _authNotifier.addListener((state) {
      authStatus = state.authStatus;
    });
  }

  AuthStatus get authStatus => _authStatus;

// Cuando cambie el estado de authStatus, autometicamente le notifica al router
  set authStatus(AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }
}
