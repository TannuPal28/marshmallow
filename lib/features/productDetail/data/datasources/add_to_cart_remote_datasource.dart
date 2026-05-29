import 'package:dio/dio.dart';
import 'package:marshmallow/core/network/api_constants.dart';
import 'package:marshmallow/core/network/dio_client.dart';
import 'package:marshmallow/features/productDetail/data/models/add_to_cart_response_model.dart';

class AddToCartRemoteDatasource {
  final DioClient dioClient;

  AddToCartRemoteDatasource(this.dioClient);

  Future<AddToCartResponseModel> addToCart({
    required String productId,
    required int quantity,
    String? variantId,
  }) async {
    try{
      final response= await dioClient.post(ApiConstants.addToCart,data: {
        "productId": productId,
        "quantity": quantity,
        "variantId": variantId,
      });
      return AddToCartResponseModel.fromJson(response.data);
    }
    on DioException catch(e){
      throw Exception(
        e.response?.data["message"] ??
            e.message,
      );
    }
  }
}
