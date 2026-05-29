import 'package:flutter/cupertino.dart';
import 'package:marshmallow/features/auth/data/models/login_response_model.dart';
import 'package:marshmallow/features/auth/data/repositories/login_repository.dart';

class LoginProvider extends ChangeNotifier {
  final LoginRepository loginRepository;

  LoginProvider(this.loginRepository);

  bool isLoading = false;
  String errorMessage = "";

  LoginResponseModel? loginResponseModel;

  Future<LoginResponseModel?> login({
    required String type,
    required String countryCode,

    String? mobile,
    String? email,

    String? emailOrMobile,
    String? password,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await loginRepository.login(
        type: type,
        countryCode: countryCode,

        mobile: mobile,
        email: email,

        emailOrMobile: emailOrMobile,

        password: password,
      );
      loginResponseModel = response;

      return response;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;

      notifyListeners();
    }
    return null;
  }

  Future<dynamic> forgotPassword({
    required String type,
    required String countryCode,
    String? mobile,
    String? email,
  }) async {

    try {

      isLoading = true;

      notifyListeners();

      final response =
      await loginRepository.forgotPassword(
        type: type,
        countryCode: countryCode,
        mobile: mobile,
        email: email,
      );

      return response;

    } catch (e) {

      errorMessage = e.toString();

    } finally {

      isLoading = false;

      notifyListeners();
    }

    return null;
  }
}

