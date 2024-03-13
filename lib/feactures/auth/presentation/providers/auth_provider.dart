import 'package:app_ciudadano_vc/feactures/auth/domain/auth_domain.dart';
import 'package:app_ciudadano_vc/feactures/auth/domain/repositories/auth_repository.dart';
import 'package:app_ciudadano_vc/feactures/auth/infraestructure/auth_infraestructure.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/services/shared_preferences/key_value_storage_impl.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/services/shared_preferences/key_value_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageImpl();

  return AuthNotifier(
      authRepository: authRepository,
      keyValueStorageService: keyValueStorageService);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier(
      {required this.keyValueStorageService, required this.authRepository})
      : super(AuthState(errorMessage: ''));

  Future<void> loginUSer(String identifier) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.sendPhoneNumber(identifier);

      _setLogUSer(user);
    } on WrongCredentials {
      logout(errorMessage: 'Crendeciales invalidas');
    } catch (e) {
      logout(errorMessage: '¡Error!');
    }
  }

  Future<void> logout({String? errorMessage}) async {
    await keyValueStorageService.removeKey('token');
    state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: null,
        errorMessage: errorMessage);
  }

  void _setLogUSer(User user) async {
    await keyValueStorageService.setKeyValue('token', user.token);

    state = state.copyWith(
      authStatus: AuthStatus.authenticated,
      user: user,
      errorMessage: '',
    );
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

// Estado de la peticion
class AuthState {
  final AuthStatus? authStatus;
  final User? user;
  final String errorMessage;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      required this.errorMessage});

  AuthState copyWith(
          {AuthStatus? authStatus, User? user, String? errorMessage}) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          errorMessage: errorMessage ?? this.errorMessage,
          user: user ?? this.user);
}
