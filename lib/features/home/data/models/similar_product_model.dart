class SimilarProductModel {
  final bool success;
  final String message;
  final List<SimilarProductResult> results;

  SimilarProductModel({
    required this.success,
    required this.message,
    required this.results,
  });

  factory SimilarProductModel.fromJson(Map<String, dynamic> json) {
    return SimilarProductModel(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      results: (json['results'] as List?)
          ?.map((e) => SimilarProductResult.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class SimilarProductResult {
  final List<SimilarProductItem> product;
  final List<TotalCount> totalCount;

  SimilarProductResult({
    required this.product,
    required this.totalCount,
  });

  factory SimilarProductResult.fromJson(Map<String, dynamic> json) {
    return SimilarProductResult(
      product: (json['product'] as List?)
          ?.map((e) => SimilarProductItem.fromJson(e))
          .toList() ??
          [],
      totalCount: (json['totalCount'] as List?)
          ?.map((e) => TotalCount.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class SimilarProductItem {
  final String id;
  final String title;
  final String slug;
  final String type;
  final double price;
  final double mrp;
  final int discountPercent;
  final SimilarRating rating;
  final int returnWindow;
  final String brandName;
  final String categoryName;
  final dynamic firstVariantId;
  final int stocks;
  final bool returnable;
  final bool replaceable;
  final String detailLink;
  final List<dynamic> variantImage;
  final List<String> images;

  SimilarProductItem({
    required this.id,
    required this.title,
    required this.slug,
    required this.type,
    required this.price,
    required this.mrp,
    required this.discountPercent,
    required this.rating,
    required this.returnWindow,
    required this.brandName,
    required this.categoryName,
    required this.firstVariantId,
    required this.stocks,
    required this.returnable,
    required this.replaceable,
    required this.detailLink,
    required this.variantImage,
    required this.images,
  });

  factory SimilarProductItem.fromJson(Map<String, dynamic> json) {
    return SimilarProductItem(
      id: json['_id'] ?? "",
      title: json['title'] ?? "",
      slug: json['slug'] ?? "",
      type: json['type'] ?? "",
      price: (json['price'] ?? 0).toDouble(),
      mrp: (json['mrp'] ?? 0).toDouble(),
      discountPercent: json['discountPercent'] ?? 0,
      rating: SimilarRating.fromJson(json['rating'] ?? {}),
      returnWindow: json['returnWindow'] ?? 0,
      brandName: json['brandName'] ?? "",
      categoryName: json['categoryName'] ?? "",
      firstVariantId: json['firstVariantId'],
      stocks: json['stocks'] ?? 0,
      returnable: json['returnable'] ?? false,
      replaceable: json['replaceable'] ?? false,
      detailLink: json['detailLink'] ?? "",
      variantImage: json['variantImage'] ?? [],
      images: List<String>.from(json['images'] ?? []),
    );
  }
}

class SimilarRating {
  final double rating;
  final int totalReviews;

  SimilarRating({
    required this.rating,
    required this.totalReviews,
  });

  factory SimilarRating.fromJson(Map<String, dynamic> json) {
    return SimilarRating(
      rating: (json['rating'] ?? 0).toDouble(),
      totalReviews: json['totalReviews'] ?? 0,
    );
  }
}

class TotalCount {
  final int count;

  TotalCount({
    required this.count,
  });

  factory TotalCount.fromJson(Map<String, dynamic> json) {
    return TotalCount(
      count: json['count'] ?? 0,
    );
  }
}