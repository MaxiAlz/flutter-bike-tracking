abstract class AuthServicesDomain {
  Future sendPhoneService(String phoneNumber);
  Future verifyCodeService({required String phoneNumber, required String code});
  Future checkAuthStatusService(String token);
}

abstract class RegisterServiceDomain {
  Future registerUser({required files, required userData});
}
