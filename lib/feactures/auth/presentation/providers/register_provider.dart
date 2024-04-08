import 'package:app_ciudadano_vc/feactures/auth/domain/auth_domain.dart';
import 'package:app_ciudadano_vc/feactures/auth/infraestructure/auth_infraestructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerProvider =
    StateNotifierProvider<RegisterNotifier, RegisterState>((ref) {
  final authRepository = AuthRepositoryImpl();

  return RegisterNotifier(authRepository: authRepository);
});

class RegisterNotifier extends StateNotifier<RegisterState> {
  final AuthRepository authRepository;
  RegisterNotifier({required this.authRepository}) : super(RegisterState());

  void registerUSer(UserRegistrationData userRegistrationData) async {
    final register = await authRepository.registerUser(userRegistrationData);
    print('===>::register::==> $register');
    // state = state.copyWith();
  }
}

enum RegisterStatus { checking, sucess, failed }

class RegisterState {
  final RegisterStatus registerStatus;
  final String errorMessage;

  RegisterState({
    this.registerStatus = RegisterStatus.checking,
    this.errorMessage = '',
  });

  RegisterState copyWith({
    RegisterStatus? registerStatus,
    String? errorMessage,
  }) =>
      RegisterState(
        registerStatus: registerStatus ?? this.registerStatus,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
