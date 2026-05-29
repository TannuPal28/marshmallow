import 'package:dio/dio.dart';
import 'package:marshmallow/features/auth/data/datasources/seller_register_remote_datasource.dart';
import 'package:marshmallow/features/auth/data/models/seller_register_response_model.dart';

class SellerRegisterRepository {
  final SellerRegisterRemoteDatasource datasource;

  SellerRegisterRepository(this.datasource);

  Future<SellerRegisterResponseModel> sellerRegister({
    required FormData formData,
  }) async {
    final response= await datasource.sellerRegister(formData: formData);
    return response;
  }
}
