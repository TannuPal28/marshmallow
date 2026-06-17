class WishlistModel {
  final bool success;
  final String message;
  final WishlistResult results;

  WishlistModel({
    required this.success,
    required this.message,
    required this.results,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      results: WishlistResult.fromJson(json['results'] ?? {}),
    );
  }
}

class WishlistResult {
  final String id;
  final String userId;
  final List<WishlistItem> items;

  WishlistResult({
    required this.id,
    required this.userId,
    required this.items,
  });

  factory WishlistResult.fromJson(Map<String, dynamic> json) {
    return WishlistResult(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      items: (json['items'] as List?)
          ?.map((e) => WishlistItem.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class WishlistItem {
  final String id;
  final ProductLite product;
  final VariantLite variant;

  WishlistItem({
    required this.id,
    required this.product,
    required this.variant,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      id: json['_id'] ?? '',
      product: ProductLite.fromJson(json['productId'] ?? {}),
      variant: VariantLite.fromJson(json['variantId'] ?? {}),
    );
  }
}
class ProductLite {
  final String id;
  final String title;
  final List<String> images;

  ProductLite({
    required this.id,
    required this.title,
    required this.images,
  });

  factory ProductLite.fromJson(Map<String, dynamic> json) {
    return ProductLite(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      images: (json['images'] as List?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
    );
  }
}
class VariantLite {
  final String id;
  final double price;
  final double mrp;
  final String colorHex;

  VariantLite({
    required this.id,
    required this.price,
    required this.mrp,
    required this.colorHex,
  });

  factory VariantLite.fromJson(Map<String, dynamic> json) {
    return VariantLite(
      id: json['_id'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      mrp: (json['mrp'] ?? 0).toDouble(),
      colorHex: json['colorHexCode'] ?? '',
    );
  }
}