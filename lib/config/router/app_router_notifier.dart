import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final goRouterNotifierProvider = Provider((ref) {
  
  final authNotifier = ref.read(authProvider.notifier);

  return GoRouterNofier(authNotifier);
});

// Permite poner un lstener en el router para
class GoRouterNofier extends ChangeNotifier {
  final AuthNotifier _authNotifier;

  AuthStatus _authStatus = AuthStatus.checking;

  GoRouterNofier(this._authNotifier) {
    _authNotifier.addListener((state) {
      authStatus = state.authStatus!;
    });
  }

  AuthStatus get authStatus => _authStatus;

  set authStatus(AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }
}
