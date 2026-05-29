
import 'package:marshmallow/core/network/api_constants.dart';
import 'package:marshmallow/core/network/dio_client.dart';

class VerifyForgotPasswordOtpDatasource {
  final DioClient dioClient;

  VerifyForgotPasswordOtpDatasource(this.dioClient);

  Future<dynamic> verifyForgotPasswordOtp({
    required String type,
    required String countryCode,
    required int otp,
    String? mobile,
    String? email,
  }) async {

    final response= await dioClient.post(ApiConstants.verifyUserForgotPasswordOTP,

      data: {

        "type": type,

        "countryCode": countryCode,

        "otp": otp,

        if (type == "mobile")
          "mobile": mobile,

        if (type == "email")
          "email": email,
      },
    );

    return response.data;
  }
}
