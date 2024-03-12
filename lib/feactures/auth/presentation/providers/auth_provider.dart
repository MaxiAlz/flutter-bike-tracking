import 'package:app_ciudadano_vc/feactures/auth/domain/auth_domain.dart';
import 'package:app_ciudadano_vc/feactures/auth/domain/repositories/auth_repository.dart';
import 'package:app_ciudadano_vc/feactures/auth/infraestructure/auth_infraestructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();

  return AuthNotifier(authRepository: authRepository);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  AuthNotifier({required this.authRepository}) : super(AuthState());

  Future<void> loginUSer(String identifier) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.sendPhoneNumber(identifier);

      _setLogUSer(user);
    } on WrongCredentials {
      logout('Crendeciales invalidas');
    } catch (e) {
      logout('¡Error!');
    }
  }

  Future<void> logout(String errorMessage) async {
    state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: null,
        errorMessage: errorMessage);
  }

  void _setLogUSer(User user) {
    //TODO: Guardat el token fisicamente:

    print(user);
    state = state.copyWith(
      authStatus: AuthStatus.authenticated,
      user: user,
    );
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

// Estado de la peticion
class AuthState {
  final AuthStatus? authStatus;
  final User? user;
  final String? errorMessage;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.errorMessage = ''});

  AuthState copyWith(
          {AuthStatus? authStatus, User? user, String? errorMessage}) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          errorMessage: errorMessage ?? this.errorMessage,
          user: user ?? this.user);
}
