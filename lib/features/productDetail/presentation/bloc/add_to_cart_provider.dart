import 'package:flutter/cupertino.dart';
import 'package:marshmallow/features/productDetail/data/models/add_to_cart_response_model.dart';
import 'package:marshmallow/features/productDetail/data/repositories/add_to_cart_repository.dart';

class AddToCartProvider extends ChangeNotifier {
  final AddToCartRepository repository;

  AddToCartProvider(this.repository);

  bool isAdding = false;
  AddToCartResponseModel? addToCartResponse;

  Future<bool> addToCart({
    required String productId,
    required int quantity,
    String? variantId,
  }) async {
    try {
      isAdding = true;
      notifyListeners();
      addToCartResponse = await repository.addToCart(
        productId: productId,
        quantity: quantity,
        variantId: variantId,
      );
      return addToCartResponse?.success ?? false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      isAdding = false;
      notifyListeners();
    }
  }
}
