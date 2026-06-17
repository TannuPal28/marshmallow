class CartModel {
  final bool success;
  final String message;
  final CartResults results;

  CartModel({
    required this.success,
    required this.message,
    required this.results,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      results: CartResults.fromJson(json['results'] ?? {}),
    );
  }
}

class CartResults {
  final String id;
  final String userId;
  final List<CartItem> items;
  final CartSummary summary;

  CartResults({
    required this.id,
    required this.userId,
    required this.items,
    required this.summary,
  });

  factory CartResults.fromJson(Map<String, dynamic> json) {
    return CartResults(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      items: (json['items'] as List?)
          ?.map((e) => CartItem.fromJson(e))
          .toList() ??
          [],
      summary: CartSummary.fromJson(
        json['summary'] ?? {},
      ),
    );
  }
}

class CartItem {
  final String id;
  final String productId;
  final String? variantId;
  final int quantity;
  final double price;
  final String title;
  final String thumbnail;
  final List<CartAttribute> attributes;

  CartItem({
    required this.id,
    required this.productId,
    this.variantId,
    required this.quantity,
    required this.price,
    required this.title,
    required this.thumbnail,
    required this.attributes,
  });

  CartItem copyWith({
    String? id,
    String? productId,
    String? variantId,
    int? quantity,
    double? price,
    String? title,
    String? thumbnail,
    List<CartAttribute>? attributes,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      variantId: variantId ?? this.variantId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      attributes: attributes ?? this.attributes,
    );
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['_id'] ?? '',
      productId: json['productId'] ?? '',
      variantId: json['variantId'],
      quantity: json['quantity'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      title: json['title'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      attributes: (json['attributes'] as List?)
          ?.map((e) => CartAttribute.fromJson(e))
          .toList() ??
          [],
    );
  }
}
class CartAttribute {
  final String attributeId;
  final String value;

  CartAttribute({
    required this.attributeId,
    required this.value,
  });

  factory CartAttribute.fromJson(Map<String, dynamic> json) {
    return CartAttribute(
      attributeId: json['attributeId'] ?? '',
      value: json['value'] ?? '',
    );
  }
}

class CartSummary {
  final int items;
  final double subtotal;

  CartSummary({
    required this.items,
    required this.subtotal,
  });

  factory CartSummary.fromJson(Map<String, dynamic> json) {
    return CartSummary(
      items: json['items'] ?? 0,
      subtotal: (json['subtotal'] ?? 0).toDouble(),
    );
  }
}