import 'package:marshmallow/core/network/api_constants.dart';
import 'package:marshmallow/core/network/dio_client.dart';
import 'package:marshmallow/features/auth/data/models/register_model.dart';

class RegisterRemoteDatasource {
  final DioClient dioClient;

  RegisterRemoteDatasource(this.dioClient);

  Future<RegisterModel> register({
    required String fullName,
    required String email,
    required String mobile,
    required String password,
    required String countryCode
  }) async {
    final response= await dioClient.post(ApiConstants.register,
    data: {
      "fullName": fullName,
      "mobile": mobile,
      "email": email,
      "countryCode": countryCode,
      "password": password,
    });
    return RegisterModel.fromJson(response.data);
  }
}
