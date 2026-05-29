import 'package:marshmallow/features/auth/data/datasources/verify_remote_otp_datasource.dart';
import 'package:marshmallow/features/auth/data/models/verify_otp_response_model.dart';

class VerifyOtpRepository {
  final VerifyRemoteOtpDatasource datasource;

  VerifyOtpRepository(this.datasource);

  Future<VerifyOtpResponseModel> verifyOTP({
    required bool fromLogin,
    required int? otpMobile,
    required int? otpEmail,
    required String mobile,
    required String email,
  }) async {
    return await datasource.verifyOTP(
      fromLogin: fromLogin,
      otpMobile: otpMobile,
      otpEmail: otpEmail,
      mobile: mobile,
      email: email,
    );
  }
}