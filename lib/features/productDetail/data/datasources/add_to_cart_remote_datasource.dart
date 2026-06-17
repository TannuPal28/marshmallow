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
    try {
      final response = await dioClient.post(
        ApiConstants.addToCart,
        data: {
          "productId": productId,
          "quantity": quantity,
          "variantId": variantId,
        },
      );
      return AddToCartResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<void> updateCart({
    required String cartItemId,

    required int quantity,
  }) async {
    try {
      await dioClient.put(
        ApiConstants.updateCart(cartItemId),
        data: {"quantity": quantity},
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<void> removeCart({
    required String cartItemId
})async{
    try{
      await dioClient.delete(ApiConstants.removeCart(cartItemId));
    }on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }

  }
}
