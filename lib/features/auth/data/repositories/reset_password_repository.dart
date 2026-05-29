import 'package:marshmallow/features/auth/data/datasources/reset_password_remote_datasource.dart';
import 'package:marshmallow/features/auth/data/models/reset_password_response_model.dart';

class ResetPasswordRepository {
  final ResetPasswordRemoteDatasource remoteDatasource;

  ResetPasswordRepository(this.remoteDatasource);

  Future<ResetPasswordResponseModel> resetPAssword({
    required String newPassword,
    required String confirmPassword,

    required bool isEmailSelected,

    String? email,
    String? mobile,
  }) {
    return remoteDatasource.resetPassword(
      newPassword: newPassword,
      confirmPassword: confirmPassword,
      isEmailSelected: isEmailSelected,
      email: email,

      mobile: mobile,
    );
  }
}
