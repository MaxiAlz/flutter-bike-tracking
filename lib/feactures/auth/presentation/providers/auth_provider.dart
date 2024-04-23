import 'package:app_ciudadano_vc/feactures/auth/domain/entities/auth_status.dart';
import 'package:app_ciudadano_vc/feactures/auth/domain/entities/user.dart';
import 'package:app_ciudadano_vc/feactures/auth/infraestructure/mappers/user_mapper.dart';
import 'package:app_ciudadano_vc/feactures/auth/infraestructure/service/auth_service.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/services/shared_preferences/key_value_storage_impl.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/services/shared_preferences/key_value_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authServices = AuthServices();
  final setKeyValue = KeyValueStorageImpl();

  return AuthNotifier(authService: authServices, keyValueStorage: setKeyValue);
});

class AuthState {
  final User? user;
  final String errorMessage;
  final AuthStatus authStatus;

  AuthState(
      {this.user,
      this.errorMessage = '',
      this.authStatus = AuthStatus.checking});

  AuthState copyWith({
    User? user,
    String? errorMessage,
    AuthStatus? authStatus,
  }) {
    return AuthState(
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      authStatus: authStatus ?? this.authStatus,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthServices authService;
  final KeyValueStorageService keyValueStorage;

  AuthNotifier({required this.authService, required this.keyValueStorage})
      : super(AuthState()) {
    checkAuthStatus();
  }

  Future sendPhoneToVerification({required String phoneNumber}) async {
    state = state.copyWith(authStatus: AuthStatus.checking);
    try {
      final serviceResponse = await authService.sendPhoneService(phoneNumber);

      if (serviceResponse?.statusCode == 201) {
        state = state.copyWith(authStatus: AuthStatus.notAuthenticated);
        return serviceResponse;
      }

      if (serviceResponse.statusCode == 404) {
        state = state.copyWith(authStatus: AuthStatus.notRegistered);
        return serviceResponse;
      }

      return serviceResponse;
    } on DioException catch (error) {
      return error;
    }
  }

  Future loginUser({
    required String phoneNumber,
    required String code,
  }) async {
    state = state.copyWith(authStatus: AuthStatus.checking);
    try {
      final serviceResponse = await authService.verifyCodeService(
          phoneNumber: phoneNumber, code: code);

      if (serviceResponse.statusCode == 201) {
        final token = serviceResponse.headers['authorization'][0];
        final userJson = serviceResponse.data as Map<String, dynamic>;
        final User user = UserMapper.userJsonToEntity(userJson);
        await keyValueStorage.setStringKeyValue('userToken', token);
        state =
            state.copyWith(authStatus: AuthStatus.authenticated, user: user);
        return serviceResponse;
      }

      if (serviceResponse.statusCode == 404) {
        state = state.copyWith(authStatus: AuthStatus.notAuthenticated);
        return serviceResponse;
      }

      return serviceResponse;
    } on DioException catch (error) {
      return error;
    }
  }

  Future<void> logoutUSer() async {
    await keyValueStorage.removeKey('userToken');
    state = state.copyWith(authStatus: AuthStatus.notAuthenticated, user: null);
  }

  void checkAuthStatus() async {
    final userToken = await keyValueStorage.getKeyValue<String>('userToken');
    if (userToken == null) return logoutUSer();

    try {
      final serviceResponse =
          await authService.checkAuthStatusService(userToken);
      final user = UserMapper.userJsonToEntity(serviceResponse.data);

      final newToken =
          serviceResponse.headers['authorization'][0].replaceAll('Bearer ', '');
      await keyValueStorage.setStringKeyValue('userToken', newToken);
      state = state.copyWith(authStatus: AuthStatus.authenticated, user: user);
    } catch (e) {
      logoutUSer();
    }
  }
}
