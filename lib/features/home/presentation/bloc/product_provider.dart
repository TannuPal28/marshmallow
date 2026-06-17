import 'package:flutter/cupertino.dart';
import 'package:marshmallow/features/home/data/models/cart_item_response.dart';
import 'package:marshmallow/features/home/data/models/product_model.dart';
import 'package:marshmallow/features/home/data/models/similar_product_model.dart';
import 'package:marshmallow/features/home/data/models/wishListModel.dart';
import 'package:marshmallow/features/home/data/repositories/product_repository.dart';

import '../../data/models/get_wishlist_model.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepository repository;

  ProductProvider(this.repository);

  // ================= PRODUCTS =================

  List<ProductItem> products = [];
  List<SimilarProductItem> similarProducts = [];


  bool isLoading = false;
  bool isPaginationLoading = false;
  bool isWishlistLoading = false;

  int currentPage = 1;
  final int pageSize = 10;

  bool hasMore = true;

  int get totalCartQuantity {
    return cartItems.fold(
      0,
          (sum, item) => sum + item.quantity,
    );
  }

  Future<void> fetchProducts({bool isLoadMore = false}) async {
    try {
      if (isPaginationLoading || !hasMore) return;

      if (!isLoadMore) {
        isLoading = true;
      } else {
        isPaginationLoading = true;
      }

      notifyListeners();

      final response = await repository.getProducts(
        page: currentPage,
        pageSize: pageSize,
      );

      if (isLoadMore) {
        products.addAll(response);
      } else {
        products = response;
      }

      if (response.length < pageSize) {
        hasMore = false;
      }

      currentPage++;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      isPaginationLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshProducts() async {
    currentPage = 1;
    hasMore = true;
    products.clear();
    await fetchProducts();
  }

  Future<void> fetchSimilarProducts({
    required String categoryId,
    required String productId,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await repository.getSimilarProducts(
        categoryId: categoryId,
        productId: productId,
      );

      similarProducts = response;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ================= CART =================

  List<CartItem> cartItems = [];
  CartModel? cartModel;

  bool _cartLoaded = false;
  bool _cartDirty = true;
  bool _cartLoading = false;

  bool get cartLoaded => _cartLoaded;

  void markCartDirty() {
    _cartDirty = true;
  }

  Future<void> loadCartIfNeeded({
    bool forceRefresh = false,
  }) async {
    if (_cartLoading) return;

    if (!forceRefresh &&
        _cartLoaded &&
        !_cartDirty) {
      return;
    }

    try {
      _cartLoading = true;

      cartModel = await repository.fetchCart();

      cartItems = cartModel?.results.items ?? [];

      _cartLoaded = true;
      _cartDirty = false;

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _cartLoading = false;
    }
  }

  CartItem? getCartItem(String productId) {
    try {
      return cartItems.firstWhere(
            (e) => e.productId == productId,
      );
    } catch (_) {
      return null;
    }
  }

  bool isProductInCart(String productId) {
    return cartItems.any(
          (e) => e.productId == productId,
    );
  }

  // ================= LOCAL CART UPDATE =================

  void addLocalCartIqtem(CartItem item) {
    cartItems.add(item);
    notifyListeners();
  }

  void removeLocalCartItem(String cartItemId) {
    cartItems.removeWhere(
          (e) => e.id == cartItemId,
    );
    notifyListeners();
  }

  void updateLocalCartQuantity(
      String cartItemId,
      int quantity,
      ) {
    final index = cartItems.indexWhere(
          (e) => e.id == cartItemId,
    );

    if (index != -1) {
      cartItems[index] = cartItems[index].copyWith(
        quantity: quantity,
      );

      notifyListeners();
    }
  }


  // wishlist add

  WishlistModel? wishlistModel;
  Set<String> wishlistIds = {};


  Future<void> wishlistAdd({
    required String productId,
    required String variantId,
  }) async {
    try {
      isWishlistLoading = true;
      notifyListeners();

      wishlistModel = await repository.wishlistAdd(
        productId: productId,
        variantId: variantId,
      );
      wishlistIds.add(productId);


    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isWishlistLoading = false;
      notifyListeners();
    }
  }

  bool isWishlisted(String productId) {
    return wishlistIds.contains(productId);
  }

  void toggleWishlist(String productId) {
    if (wishlistIds.contains(productId)) {
      wishlistIds.remove(productId);
    } else {
      wishlistIds.add(productId);
    }
    notifyListeners();
  }

  //remove wishlist
  String? removingWishlistProductId;
  Future<void> wishlistRemove({
    required String productId,
    required String variantId,
  }) async {
    try {
      isWishlistLoading = true;
      removingWishlistProductId = productId;
      notifyListeners();

      wishlistModel = await repository.wishlistRemove(
        productId: productId,
        variantId: variantId,
      );
      wishlistIds.remove(productId);

    } catch (e) {
      debugPrint(e.toString());
    } finally {
      removingWishlistProductId = null;
      isWishlistLoading = false;
      notifyListeners();
    }
  }

  int get wishlistCount => wishlistIds.length;

  //getwishlist

  GetWishlistModel? wishlistData;
  Future<GetWishlistModel> fetchWishlist() async {
    try {
      final response = await repository.getWishlist();
      wishlistData = response;

      wishlistIds = response.results.items
          .map((e) => e.productId)
          .toSet();

      notifyListeners();

      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow; // or throw Exception
    }
  }

  Future<void> toggleWishlistAPI({
    required String productId,
    required String variantId,
  }) async {
    if (wishlistIds.contains(productId)) {
      await wishlistRemove(productId: productId, variantId: variantId);
    } else {
      await wishlistAdd(
        productId: productId,
        variantId: variantId,
      );
    }
  }
}