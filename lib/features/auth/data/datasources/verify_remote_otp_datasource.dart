import 'package:marshmallow/core/network/api_constants.dart';
import 'package:marshmallow/core/network/dio_client.dart';
import 'package:marshmallow/features/auth/data/models/verify_otp_response_model.dart';

class VerifyRemoteOtpDatasource {
  final DioClient dioClient;

  VerifyRemoteOtpDatasource(this.dioClient);

  Future<VerifyOtpResponseModel> verifyOTP({
    required bool fromLogin,
    int? otpMobile,
    int? otpEmail,
    String? mobile,
    String? email,
  }) async {

    Map<String, dynamic> body = {};

    /// LOGIN WITH MOBILE
    if (otpMobile != null &&
        mobile != null &&
        mobile.isNotEmpty &&
        (email == null || email.isEmpty)) {

      body = {
        "otp": otpMobile,
        "mobile": mobile,
        "deviceId": null,
        "deviceType": null,
        "deviceToken": null,
      };
    }

    /// LOGIN WITH EMAIL
    else if (otpEmail != null &&
        email != null &&
        email.isNotEmpty &&
        (mobile == null || mobile.isEmpty)) {

      body = {
        "otp": otpEmail,
        "email": email,
        "deviceId": null,
        "deviceType": null,
        "deviceToken": null,
      };
    }

    /// SIGNUP (BOTH OTP)
    else {

      body = {
        "otpMobile": otpMobile,
        "otpEmail": otpEmail,
        "mobile": mobile ?? "",
        "email": email ?? "",
        "deviceId": null,
        "deviceType": null,
        "deviceToken": null,
      };
    }

    final response = await dioClient.post(
      fromLogin
          ? ApiConstants.verifyLoginOtp

      /// REGISTER OTP VERIFY API
          : ApiConstants.verifyOtp,
      data: body,
    );

    return VerifyOtpResponseModel.fromJson(response.data);
  }
}