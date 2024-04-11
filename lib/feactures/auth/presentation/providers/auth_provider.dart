import 'package:app_ciudadano_vc/feactures/auth/domain/entities/auth_status.dart';
import 'package:app_ciudadano_vc/feactures/auth/domain/entities/user.dart';
import 'package:app_ciudadano_vc/feactures/auth/service/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authServices = AuthServices();
  return AuthNotifier(authServices);
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
  AuthNotifier(this.authService) : super(AuthState());

  Future sendPhoneToVerification({required String phoneNumber}) async {
    state = state.copyWith(authStatus: AuthStatus.checking);
    try {
      final serviceResponse = await authService.sendPhoneService(phoneNumber);

      if (serviceResponse.statusCode == 201) {
        state = state.copyWith(authStatus: AuthStatus.registered);
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
}
