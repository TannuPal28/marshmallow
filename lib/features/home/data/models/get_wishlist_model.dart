class GetWishlistModel {
  final bool success;
  final String message;
  final WishlistResult results;

  GetWishlistModel({
    required this.success,
    required this.message,
    required this.results,
  });

  factory GetWishlistModel.fromJson(Map<String, dynamic> json) {
    return GetWishlistModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      results: WishlistResult.fromJson(json['results'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'results': results.toJson(),
    };
  }
}

class WishlistResult {
  final String id;
  final String userId;
  final List<WishlistItem> items;
  final String createdAt;
  final String updatedAt;

  WishlistResult({
    required this.id,
    required this.userId,
    required this.items,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WishlistResult.fromJson(Map<String, dynamic> json) {
    return WishlistResult(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => WishlistItem.fromJson(e))
          .toList(),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'items': items.map((e) => e.toJson()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class WishlistItem {
  final String id;
  final String productId;
  final String variantId;
  final String title;
  final double price;
  final double mrp;
  final String thumbnail;
  final List<String> productImages;
  final List<String> variantImages;

  WishlistItem({
    required this.id,
    required this.productId,
    required this.variantId,
    required this.title,
    required this.price,
    required this.mrp,
    required this.thumbnail,
    required this.productImages,
    required this.variantImages,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      id: json['_id'] ?? '',
      productId: json['productId'] ?? '',
      variantId: json['variantId'] ?? '',
      title: json['title'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      mrp: (json['mrp'] ?? 0).toDouble(),
      thumbnail: json['thumbnail'] ?? '',
      productImages: List<String>.from(json['productImages'] ?? []),
      variantImages: List<String>.from(json['variantImages'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productId': productId,
      'variantId': variantId,
      'title': title,
      'price': price,
      'mrp': mrp,
      'thumbnail': thumbnail,
      'productImages': productImages,
      'variantImages': variantImages,
    };
  }
}