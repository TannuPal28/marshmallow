import 'package:flutter/cupertino.dart';
import 'package:marshmallow/features/productDetail/data/models/add_to_cart_response_model.dart';
import 'package:marshmallow/features/productDetail/data/repositories/add_to_cart_repository.dart';

class AddToCartProvider extends ChangeNotifier {
  final AddToCartRepository repository;

  AddToCartProvider(this.repository);

  String updatingCartId = "";
  String removingCartId = "";


  bool isAdding = false;
  AddToCartResponseModel? addToCartResponse;
  String addingProductId = "";

  Future<bool> addToCart({
    required String productId,
    required int quantity,
    String? variantId,
  }) async {
    try {
      addingProductId = productId;
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
      addingProductId = "";
      isAdding = false;
      notifyListeners();
    }
  }


  Future<void> updateCart({
    required String cartItemId,
    required int quantity,
  }) async {
    try {
      updatingCartId = cartItemId;
      notifyListeners();

      await repository.updateCart(
        cartItemId: cartItemId,
        quantity: quantity,
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      updatingCartId = "";
      notifyListeners();
    }
  }

  Future<void> removeCart({
    required String cartItemId,
  }) async {
    try {
      removingCartId = cartItemId;
      notifyListeners();
      await repository.removeCart(
        cartItemId: cartItemId,
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      removingCartId = "";
      notifyListeners();
    }
  }


}
