import 'package:marshmallow/features/auth/data/datasources/login_remote_datasource.dart';
import 'package:marshmallow/features/auth/data/models/login_response_model.dart';

class LoginRepository {
  final LoginRemoteDatasource remoteDatasource;

  LoginRepository(this.remoteDatasource);

  Future<LoginResponseModel> login({
    required String type,
    required String countryCode,

    String? mobile,
    String? email,

    String? emailOrMobile,
    String? password,
  }) {
    return remoteDatasource.login(
      type: type,
      countryCode: countryCode,
      mobile: mobile,
      email: email,

      emailOrMobile: emailOrMobile,

      password: password,
    );
  }

  Future<dynamic> forgotPassword({
    required String type,
    required String countryCode,
    String? mobile,
    String? email,
  }) {

    return remoteDatasource.forgotPassword(
      type: type,
      countryCode: countryCode,
      mobile: mobile,
      email: email,
    );
  }
}
