import 'package:sewa_digital/data/dataProviders/data_providers.dart';
import 'package:sewa_digital/data/model/auth_response.dart';
import 'package:sewa_digital/data/model/password_response.dart';
import 'package:sewa_digital/data/model/register_response.dart';

abstract class AuthRepo {
  Future<AuthResponse> performLogin(String email, String password);
  Future<AuthResponse> performSocialLogin(
      String name, String email, String provider);
  Future<RegisterResponse> performRegister(String fullName, String email,
      String password, String confirmPassword, String phone);
  Future<AuthResponse> performLogout();
  Future<ChangePasswordResponse> changePassword(
    String password,
    String oldPassword,
  );
  Future<ChangePasswordResponse> forgotPassword(String email);
}

class RealAuthRepo implements AuthRepo {
  final DataProvider _dataProvider = DataProvider();
  @override
  Future<AuthResponse> performLogin(String email, String password) {
    return _dataProvider.performLogin(email, password);
  }

  @override
  Future<RegisterResponse> performRegister(String fullName, String email,
      String password, String confirmPassword, String phone) {
    return _dataProvider.performRegister(
        fullName, email, password, confirmPassword, phone);
  }

  @override
  Future<AuthResponse> performLogout() {
    return DataProvider().performLogout();
  }

  @override
  Future<ChangePasswordResponse> changePassword(
    String password,
    String oldPassword,
  ) {
    return _dataProvider.updatePassword(password, oldPassword);
  }

  @override
  Future<ChangePasswordResponse> forgotPassword(String email) {
    return _dataProvider.forgotPassword(email);
  }

  @override
  Future<AuthResponse> performSocialLogin(
      String name, String email, String provider) {
    return _dataProvider.performSocialLogin(name, email, provider);
  }
}
