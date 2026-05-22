import 'package:marshmallow/features/auth/data/datasources/register_remote_datasource.dart';
import 'package:marshmallow/features/auth/data/models/register_model.dart';

class RegisterRepository {
  final RegisterRemoteDatasource remoteDatasource;
  RegisterRepository(this.remoteDatasource);
  Future<RegisterModel> register({
    required String fullName,
    required String email,
    required String mobile,
    required String password,
    required String countryCode
}){
    return remoteDatasource.register(fullName: fullName, email: email, mobile: mobile, password: password, countryCode: countryCode);
  }
}