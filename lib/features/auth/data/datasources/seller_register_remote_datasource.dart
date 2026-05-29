import 'package:dio/dio.dart';
import 'package:marshmallow/core/network/api_constants.dart';
import 'package:marshmallow/core/network/dio_client.dart';
import 'package:marshmallow/features/auth/data/models/seller_register_response_model.dart';

class SellerRegisterRemoteDatasource {
  final DioClient dioClient;

  SellerRegisterRemoteDatasource(this.dioClient);

  Future<SellerRegisterResponseModel> sellerRegister({
    required FormData formData,
  }) async {

    final response = await dioClient.post(
      ApiConstants.sellerRegister,
      data: formData,
      customBaseUrl: ApiConstants.merchantBaseUrl,
    );

    return SellerRegisterResponseModel.fromJson(response.data);
  }
}