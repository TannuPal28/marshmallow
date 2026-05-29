import 'package:dio/dio.dart';
import 'package:marshmallow/core/network/api_constants.dart';
import 'package:marshmallow/core/network/dio_client.dart';
import 'package:marshmallow/features/productDetail/data/models/product_detail_model.dart';

class ProductDetailRemoteDatasource {
  final DioClient dioClient;

  ProductDetailRemoteDatasource(this.dioClient);

  Future<ProductDetailModel> getDetail(String productId) async {
    try {

      final response =
      await dioClient.get(ApiConstants.productDetail(productId));

      final data = response.data;

      print("PRODUCT DETAIL RESPONSE => $data");

      if (data['success'] == true &&
          data['results'] != null &&
          data['results'].isNotEmpty) {

        return ProductDetailModel.fromJson(data['results'][0]);
      }

      throw Exception("Product data not found");

    } on DioException catch (e) {

      throw Exception(e.response?.data?['message'] ??
          e.message ??
          "Something went wrong");
    }
  }
}