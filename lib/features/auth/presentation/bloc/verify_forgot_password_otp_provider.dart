import 'package:flutter/material.dart';

import '../../data/repositories/verify_forgot_password_otp_repository.dart';

class VerifyForgotPasswordOtpProvider extends ChangeNotifier {

  final VerifyForgotPasswordOtpRepository repository;

  VerifyForgotPasswordOtpProvider(this.repository);

  bool isLoading = false;

  String errorMessage = "";

  Future<dynamic> verifyForgotPasswordOtp({
    required String type,
    required String countryCode,
    required int otp,
    String? mobile,
    String? email,
  }) async {

    try {

      isLoading = true;

      notifyListeners();

      final response =
      await repository.verifyForgotPasswordOtp(
        type: type,
        countryCode: countryCode,
        otp: otp,
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
  }
}