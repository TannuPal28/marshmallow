import 'package:dio/dio.dart';
import 'package:marshmallow/core/network/api_constants.dart';
import 'package:marshmallow/core/network/dio_client.dart';
import 'package:marshmallow/features/home/data/models/product_model.dart';
import 'package:marshmallow/features/home/data/models/similar_product_model.dart';
import 'package:marshmallow/features/home/data/models/wishListModel.dart';

import '../models/cart_item_response.dart';
import '../models/get_wishlist_model.dart';

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

  Future<CartModel> fetchCart() async {
    try {
      final response = await dioClient.get(
        ApiConstants.getCart,
      );

      final model = CartModel.fromJson(response.data);

      return model;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ??
            e.message ??
            "Failed to fetch cart",
      );
    }
  }


  Future<WishlistModel> addToWishlist(String productId,
      String variantId,) async {
    try {
      final response = await dioClient.post(ApiConstants.wishlistAdd, data: {
        "productId": productId,
        "variantId": variantId
      });

      return WishlistModel.fromJson(response.data);
    }
    on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ??
            e.message ??
            "Failed to fetch cart",
      );
    }
  }

  Future<WishlistModel> removeToWishlist(String productId,
      String variantId,) async {
    try {
      final response = await dioClient.delete(ApiConstants.wishlistRemove, data: {
        "productId": productId,
        "variantId": variantId
      });

      return WishlistModel.fromJson(response.data);
    }
    on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ??
            e.message ??
            "Failed to fetch cart",
      );
    }
  }

  Future<GetWishlistModel> fetchWishlist() async {
    try {
      final response = await dioClient.get(ApiConstants.getWishlist);

      final model = GetWishlistModel.fromJson(response.data);

      return model;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ??
            e.message ??
            "Failed to fetch wishlist",
      );
    }
  }
}
