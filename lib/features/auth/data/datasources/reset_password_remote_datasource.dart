import 'package:marshmallow/core/network/api_constants.dart';
import 'package:marshmallow/core/network/dio_client.dart';
import 'package:marshmallow/features/auth/data/models/reset_password_response_model.dart';

class ResetPasswordRemoteDatasource {
  final DioClient dioClient;

  ResetPasswordRemoteDatasource(this.dioClient);

  Future<ResetPasswordResponseModel> resetPassword({
    required String newPassword,
    required String confirmPassword,

    required bool isEmailSelected,

    String? email,
    String? mobile,
  }) async{
    final response= await dioClient.post(
      ApiConstants.resetPassword,
      data: {
        "newPassword": newPassword,

        "confirmPassword": confirmPassword,

        "countryCode": "91",

        if (isEmailSelected)
          "email": email,

        if (!isEmailSelected)
          "mobile": mobile,
      }
    );
    return ResetPasswordResponseModel.fromJson(response.data);
  }
}
