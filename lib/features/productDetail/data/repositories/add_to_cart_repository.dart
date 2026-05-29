import 'package:marshmallow/features/productDetail/data/datasources/add_to_cart_remote_datasource.dart';
import 'package:marshmallow/features/productDetail/data/models/add_to_cart_response_model.dart';

class AddToCartRepository {
  final AddToCartRemoteDatasource remoteDatasource;

  AddToCartRepository(this.remoteDatasource);

  Future<AddToCartResponseModel> addToCart({
    required String productId,
    required int quantity,
    String? variantId,
  }) async {
    return await remoteDatasource.addToCart(
      productId: productId,
      quantity: quantity,
      variantId: variantId,
    );
  }
}
