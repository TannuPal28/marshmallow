import 'package:marshmallow/core/network/api_constants.dart';
import 'package:marshmallow/core/network/dio_client.dart';
import 'package:marshmallow/features/auth/data/models/login_response_model.dart';

class LoginRemoteDatasource {
  final DioClient dioClient;

  LoginRemoteDatasource(this.dioClient);

  Future<LoginResponseModel> login({
    required String type,
    required String countryCode,
    String? mobile,
    String? email,
    String? emailOrMobile,
    String? password,
  }) async{
    final response= await dioClient.post(ApiConstants.login,data: {
      "type": type,

      "countryCode":
      countryCode,

      "deviceId": null,
      "deviceType": null,
      "deviceToken": null,
      if (type == "mobile")
        "mobile": mobile,

      if (type == "email")
        "email": email,

      if (type == "password")
        "emailOrMobile":
        emailOrMobile,
      if (type == "password")
        "password": password,
    });

    return LoginResponseModel.fromJson(response.data);
  }

  Future<dynamic> forgotPassword({
    required String type,
    required String countryCode,
    String? mobile,
    String? email,
  }) async {

    final response = await dioClient.post(
      ApiConstants.forgotPassword,

      data: {
        "type": type,

        "countryCode": countryCode,

        if (type == "mobile")
          "mobile": mobile,

        if (type == "email")
          "email": email,
      },
    );

    return response.data;
  }
}
