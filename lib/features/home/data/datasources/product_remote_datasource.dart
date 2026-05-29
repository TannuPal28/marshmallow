import 'package:dio/dio.dart';
import 'package:marshmallow/core/network/api_constants.dart';
import 'package:marshmallow/core/network/dio_client.dart';
import 'package:marshmallow/features/home/data/models/product_model.dart';
import 'package:marshmallow/features/home/data/models/similar_product_model.dart';

class ProductRemoteDatasource {
  final DioClient dioClient;

  ProductRemoteDatasource(this.dioClient);

  Future<List<ProductItem>> getProducts({
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await dioClient.get(
        ApiConstants.productList,
        queryParameters: {"page": page, "pageSize": pageSize},
      );

      final productModel = ProductModel.fromJson(response.data);
      return productModel.results.product;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<SimilarProductItem>> getSimilarProducts({
    required String categoryId,
    required String productId,
  }) async {
    try {
      final response = await dioClient.get(
        ApiConstants.similarProductList(categoryId, productId),
      );

      final model = SimilarProductModel.fromJson(response.data);

      if (model.results.isEmpty) {
        return [];
      }

      return model.results.first.product;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
