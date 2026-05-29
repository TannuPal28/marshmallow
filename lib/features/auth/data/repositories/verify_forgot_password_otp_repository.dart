import 'package:marshmallow/features/auth/data/datasources/verify_forgot_password_otp_datasource.dart';

class VerifyForgotPasswordOtpRepository {
  final VerifyForgotPasswordOtpDatasource datasource;

  VerifyForgotPasswordOtpRepository(this.datasource);

  Future<dynamic> verifyForgotPasswordOtp({
    required String type,
    required String countryCode,
    required int otp,
    String? mobile,
    String? email,
  }) async {
    return await datasource.verifyForgotPasswordOtp(
      type: type,
      countryCode: countryCode,
      otp: otp,
      mobile: mobile,
      email: email,
    );
  }
}
