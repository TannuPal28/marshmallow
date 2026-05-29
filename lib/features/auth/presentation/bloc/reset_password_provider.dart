import 'package:flutter/material.dart';
import 'package:marshmallow/features/auth/data/repositories/reset_password_repository.dart';

import '../../data/models/reset_password_response_model.dart';

class ResetPasswordProvider extends ChangeNotifier {
  final ResetPasswordRepository repository;

  ResetPasswordProvider(this.repository);

  bool isLoading = false;
  String errorMessage = "";
  ResetPasswordResponseModel? resetPasswordResponseModel;

  Future<ResetPasswordResponseModel?> resetPAssword({
    required String newPassword,
    required String confirmPassword,

    required bool isEmailSelected,

    String? email,
    String? mobile,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await repository.resetPAssword(
        newPassword: newPassword,
        confirmPassword: confirmPassword,
        isEmailSelected: isEmailSelected,
        email: email,

        mobile: mobile,
      );
      resetPasswordResponseModel = response;
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
