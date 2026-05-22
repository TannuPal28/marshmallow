class ProductModel {
  final bool success;
  final String message;
  final ProductResults results;

  ProductModel({
    required this.success,
    required this.message,
    required this.results,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      results: ProductResults.fromJson(json['results'] ?? {}),
    );
  }
}

class ProductResults {
  final int page;
  final int pageSize;
  final int totalCount;

  final List<ProductItem> product;

  ProductResults({
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.product,
  });

  factory ProductResults.fromJson(Map<String, dynamic> json) {
    return ProductResults(
      page: json['page'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      totalCount: json['totalCount'] ?? 0,

      product: json['product'] != null
          ? List<ProductItem>.from(
        json['product'].map(
              (x) => ProductItem.fromJson(x),
        ),
      )
          : [],
    );
  }
}

class ProductItem {
  final String id;
  final String merchantId;

  final String title;
  final String slug;
  final String type;

  final double price;
  final double mrp;

  final int discountPercent;

  final RatingModel rating;

  final int returnWindow;

  final String brandName;
  final String categoryName;

  final String? firstVariantId;

  final dynamic stocks;

  final bool returnable;
  final bool? replaceable;

  final String detailLink;

  final List<String?> variantImage;

  final List<String> images;

  ProductItem({
    required this.id,
    required this.merchantId,
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

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['_id'] ?? '',

      merchantId: json['merchantId'] ?? '',

      title: json['title'] ?? '',

      slug: json['slug'] ?? '',

      type: json['type'] ?? '',

      price: (json['price'] ?? 0).toDouble(),

      mrp: (json['mrp'] ?? 0).toDouble(),

      discountPercent: json['discountPercent'] ?? 0,

      rating: RatingModel.fromJson(
        json['rating'] ?? {},
      ),

      returnWindow: json['returnWindow'] ?? 0,

      brandName: json['brandName'] ?? '',

      categoryName: json['categoryName'] ?? '',

      firstVariantId: json['firstVariantId'],

      stocks: json['stocks'],

      returnable: json['returnable'] ?? false,

      replaceable: json['replaceable'],

      detailLink: json['detailLink'] ?? '',

      variantImage: json['variantImage'] != null
          ? List<String?>.from(json['variantImage'])
          : [],

      images: json['images'] != null
          ? List<String>.from(json['images'])
          : [],
    );
  }
}

class RatingModel {
  final double rating;
  final int totalReviews;

  RatingModel({
    required this.rating,
    required this.totalReviews,
  });

  factory RatingModel.fromJson(
      Map<String, dynamic> json) {
    return RatingModel(
      rating: (json['rating'] ?? 0).toDouble(),

      totalReviews:
      json['totalReviews'] ?? 0,
    );
  }
}