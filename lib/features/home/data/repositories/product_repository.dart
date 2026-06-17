import 'package:marshmallow/features/home/data/datasources/product_remote_datasource.dart';
import 'package:marshmallow/features/home/data/models/cart_item_response.dart';
import 'package:marshmallow/features/home/data/models/product_model.dart';
import 'package:marshmallow/features/home/data/models/similar_product_model.dart';
import 'package:marshmallow/features/home/data/models/wishListModel.dart';

import '../models/get_wishlist_model.dart';

class ProductRepository {
  final ProductRemoteDatasource remoteDatasource;

  ProductRepository(this.remoteDatasource);

  Future<List<ProductItem>> getProducts({
    required int page,
    required int pageSize,
  }) async {
    return await remoteDatasource.getProducts(page: page, pageSize: pageSize);
  }

  Future<List<SimilarProductItem>> getSimilarProducts({
    required String categoryId,
    required String productId,
  }) async {
    return await remoteDatasource.getSimilarProducts(
      categoryId: categoryId,
      productId: productId,
    );
  }

  Future<CartModel> fetchCart() async {
    return await remoteDatasource.fetchCart();
  }

  Future<WishlistModel?> wishlistAdd({required String productId, required String variantId}) async {
    return await remoteDatasource.addToWishlist(productId, variantId);
  }


  Future<WishlistModel?> wishlistRemove({required String productId, required String variantId}) async {
    return await remoteDatasource.removeToWishlist(productId, variantId);
  }
  Future<GetWishlistModel> getWishlist() async {
    return await remoteDatasource.fetchWishlist();
  }


}
