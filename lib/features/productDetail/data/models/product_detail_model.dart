// features/productDetail/data/models/product_detail_model.dart

class ProductDetailModel {
  final String id;
  final String merchantId;
  final String title;
  final String slug;
  final String description;
  final String shortDescription;
  final String type;
  final String categoryId;
  final String brandId;
  final List<String> images;
  final String videoUrl;
  final double? price;
  final double? mrp;
  final int discountPercent;
  final String stockType;
  final int stock;
  final RatingModel rating;
  final String sellerSKU;
  final String barcode;
  final String hsnCode;
  final int gstPercent;
  final String countryOfOrigin;
  final List<dynamic> attributes;
  final WarrantyModel warranty;
  final ManufacturerDetailsModel manufacturerDetails;
  final List<dynamic> tags;
  final List<String> keyFeatures;
  final String material;
  final String ingredients;
  final String? expiryDate;
  final String safetyWarning;
  final String careInstructions;
  final int weight;
  final int packageWeight;
  final DimensionsModel dimensions;
  final DimensionsModel packageDimensions;
  final int procurementSLA;
  final bool returnable;
  final bool replaceable;
  final int returnWindow;
  final String status;
  final String approvedBy;
  final String approvedAt;
  final String? deletedAt;
  final String? deletedBy;
  final String metaTitle;
  final String metaDescription;
  final String metaKeywords;
  final String createdAt;
  final String updatedAt;
  final int v;
  final BrandModel brand;
  final List<VariantModel> variants;
  final List<dynamic> reviews;

  ProductDetailModel({
    required this.id,
    required this.merchantId,
    required this.title,
    required this.slug,
    required this.description,
    required this.shortDescription,
    required this.type,
    required this.categoryId,
    required this.brandId,
    required this.images,
    required this.videoUrl,
    this.price,
    this.mrp,
    required this.discountPercent,
    required this.stockType,
    required this.stock,
    required this.rating,
    required this.sellerSKU,
    required this.barcode,
    required this.hsnCode,
    required this.gstPercent,
    required this.countryOfOrigin,
    required this.attributes,
    required this.warranty,
    required this.manufacturerDetails,
    required this.tags,
    required this.keyFeatures,
    required this.material,
    required this.ingredients,
    this.expiryDate,
    required this.safetyWarning,
    required this.careInstructions,
    required this.weight,
    required this.packageWeight,
    required this.dimensions,
    required this.packageDimensions,
    required this.procurementSLA,
    required this.returnable,
    required this.replaceable,
    required this.returnWindow,
    required this.status,
    required this.approvedBy,
    required this.approvedAt,
    this.deletedAt,
    this.deletedBy,
    required this.metaTitle,
    required this.metaDescription,
    required this.metaKeywords,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.brand,
    required this.variants,
    required this.reviews,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['_id'] ?? '',
      merchantId: json['merchantId'] ?? '',
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      shortDescription: json['shortDescription'] ?? '',
      type: json['type'] ?? '',
      categoryId: json['categoryId'] ?? '',
      brandId: json['brandId'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      videoUrl: json['videoUrl'] ?? '',
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      mrp: json['mrp'] != null ? (json['mrp'] as num).toDouble() : null,
      discountPercent: json['discountPercent'] ?? 0,
      stockType: json['stockType'] ?? '',
      stock: json['stock'] ?? 0,
      rating: RatingModel.fromJson(json['rating'] ?? {}),
      sellerSKU: json['sellerSKU'] ?? '',
      barcode: json['barcode'] ?? '',
      hsnCode: json['hsnCode'] ?? '',
      gstPercent: json['gstPercent'] ?? 0,
      countryOfOrigin: json['countryOfOrigin'] ?? '',
      attributes: List<dynamic>.from(json['attributes'] ?? []),
      warranty: WarrantyModel.fromJson(json['warranty'] ?? {}),
      manufacturerDetails: ManufacturerDetailsModel.fromJson(json['manufacturerDetails'] ?? {}),
      tags: List<dynamic>.from(json['tags'] ?? []),
      keyFeatures: List<String>.from(json['keyFeatures'] ?? []),
      material: json['material'] ?? '',
      ingredients: json['ingredients'] ?? '',
      expiryDate: json['expiryDate'],
      safetyWarning: json['safetyWarning'] ?? '',
      careInstructions: json['careInstructions'] ?? '',
      weight: json['weight'] ?? 0,
      packageWeight: json['packageWeight'] ?? 0,
      dimensions: DimensionsModel.fromJson(json['dimensions'] ?? {}),
      packageDimensions: DimensionsModel.fromJson(json['packageDimensions'] ?? {}),
      procurementSLA: json['procurementSLA'] ?? 0,
      returnable: json['returnable'] ?? false,
      replaceable: json['replaceable'] ?? false,
      returnWindow: json['returnWindow'] ?? 0,
      status: json['status'] ?? '',
      approvedBy: json['approvedBy'] ?? '',
      approvedAt: json['approvedAt'] ?? '',
      deletedAt: json['deletedAt'],
      deletedBy: json['deletedBy'],
      metaTitle: json['metaTitle'] ?? '',
      metaDescription: json['metaDescription'] ?? '',
      metaKeywords: json['metaKeywords'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
      brand: BrandModel.fromJson(json['brand'] ?? {}),
      variants: (json['variants'] as List? ?? [])
          .map((v) => VariantModel.fromJson(v))
          .toList(),
      reviews: List<dynamic>.from(json['reviews'] ?? []),
    );
  }
}

// --- SUB MODELS (Helper Classes for Nesting) ---

class RatingModel {
  final double rating;
  final int totalReviews;

  RatingModel({required this.rating, required this.totalReviews});

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalReviews: json['totalReviews'] ?? 0,
    );
  }
}

class WarrantyModel {
  final String duration;
  final String type;

  WarrantyModel({required this.duration, required this.type});

  factory WarrantyModel.fromJson(Map<String, dynamic> json) {
    return WarrantyModel(
      duration: json['duration'] ?? '',
      type: json['type'] ?? '',
    );
  }
}

class ManufacturerDetailsModel {
  final String name;
  final String address;

  ManufacturerDetailsModel({required this.name, required this.address});

  factory ManufacturerDetailsModel.fromJson(Map<String, dynamic> json) {
    return ManufacturerDetailsModel(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
    );
  }
}

class DimensionsModel {
  final int length;
  final int width;
  final int height;

  DimensionsModel({required this.length, required this.width, required this.height});

  factory DimensionsModel.fromJson(Map<String, dynamic> json) {
    return DimensionsModel(
      length: json['length'] ?? 0,
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
    );
  }
}

class BrandModel {
  final String id;
  final String name;
  final String slug;
  final String image;
  final String status;
  final String? deletedBy;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;
  final int v;

  BrandModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.status,
    this.deletedBy,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      image: json['image'] ?? '',
      status: json['status'] ?? '',
      deletedBy: json['deletedBy'],
      deletedAt: json['deletedAt'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }
}

class VariantAttributeModel {
  final String attributeId;
  final String value;
  final String name;

  VariantAttributeModel({
    required this.attributeId,
    required this.value,
    required this.name,
  });

  factory VariantAttributeModel.fromJson(Map<String, dynamic> json) {
    return VariantAttributeModel(
      attributeId: json['attributeId'] ?? '',
      value: json['value'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class VariantModel {
  final String id; // JSON से _id मैप होगा
  final String productId;
  final String merchantId;
  final List<VariantAttributeModel> attributes;
  final String sku;
  final String skuType;
  final String barcode;
  final double price;
  final double mrp;
  final int discountPercent;
  final int maxOrderQty;
  final bool isReturnable;
  final bool isReplaceable;
  final int returnWindow;
  final int procurementSLA;
  final String colorHexCode;
  final List<String> images;
  final int weight;
  final int packageWeight;
  final DimensionsModel dimensions;
  final DimensionsModel packageDimensions;
  final String countryOfOrigin;
  final String hsnCode;
  final int gstPercent;
  final String? expiryDate;
  final String? manufacturedDate;
  final String batchNumber;
  final String modelNumber;
  final String serialNumber;
  final String capacity;
  final String material;
  final String flavor;
  final String scent;
  final int packOf;
  final int unitCount;
  final String unitName;
  final bool fragile;
  final bool temperatureControlled;
  final RatingModel rating;
  final String status;
  final String approvedBy;
  final String approvedAt;
  final String? deletedAt;
  final String? deletedBy;
  final String createdAt;
  final String updatedAt;
  final int v;
  final num stock;
  final List<dynamic> reviews;

  VariantModel({
    required this.id,
    required this.productId,
    required this.merchantId,
    required this.attributes,
    required this.sku,
    required this.skuType,
    required this.barcode,
    required this.price,
    required this.mrp,
    required this.discountPercent,
    required this.maxOrderQty,
    required this.isReturnable,
    required this.isReplaceable,
    required this.returnWindow,
    required this.procurementSLA,
    required this.colorHexCode,
    required this.images,
    required this.weight,
    required this.packageWeight,
    required this.dimensions,
    required this.packageDimensions,
    required this.countryOfOrigin,
    required this.hsnCode,
    required this.gstPercent,
    this.expiryDate,
    this.manufacturedDate,
    required this.batchNumber,
    required this.modelNumber,
    required this.serialNumber,
    required this.capacity,
    required this.material,
    required this.flavor,
    required this.scent,
    required this.packOf,
    required this.unitCount,
    required this.unitName,
    required this.fragile,
    required this.temperatureControlled,
    required this.rating,
    required this.status,
    required this.approvedBy,
    required this.approvedAt,
    this.deletedAt,
    this.deletedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.stock,
    required this.reviews,
  });

  factory VariantModel.fromJson(Map<String, dynamic> json) {
    return VariantModel(
      id: json['_id'] ?? '', // सबसे ज़रूरी फ़िक्स
      productId: json['productId'] ?? '',
      merchantId: json['merchantId'] ?? '',
      attributes: (json['attributes'] as List? ?? [])
          .map((a) => VariantAttributeModel.fromJson(a))
          .toList(),
      sku: json['sku'] ?? '',
      skuType: json['skuType'] ?? '',
      barcode: json['barcode'] ?? '',
      price: (json['price'] as num? ?? 0).toDouble(),
      mrp: (json['mrp'] as num? ?? 0).toDouble(),
      discountPercent: json['discountPercent'] ?? 0,
      maxOrderQty: json['maxOrderQty'] ?? 0,
      isReturnable: json['isReturnable'] ?? false,
      isReplaceable: json['isReplaceable'] ?? false,
      returnWindow: json['returnWindow'] ?? 0,
      procurementSLA: json['procurementSLA'] ?? 0,
      colorHexCode: json['colorHexCode'] ?? '#FFFFFF',
      images: List<String>.from(json['images'] ?? []),
      weight: json['weight'] ?? 0,
      packageWeight: json['packageWeight'] ?? 0,
      dimensions: DimensionsModel.fromJson(json['dimensions'] ?? {}),
      packageDimensions: DimensionsModel.fromJson(json['packageDimensions'] ?? {}),
      countryOfOrigin: json['countryOfOrigin'] ?? '',
      hsnCode: json['hsnCode'] ?? '',
      gstPercent: json['gstPercent'] ?? 0,
      expiryDate: json['expiryDate'],
      manufacturedDate: json['manufacturedDate'],
      batchNumber: json['batchNumber'] ?? '',
      modelNumber: json['modelNumber'] ?? '',
      serialNumber: json['serialNumber'] ?? '',
      capacity: json['capacity'] ?? '',
      material: json['material'] ?? '',
      flavor: json['flavor'] ?? '',
      scent: json['scent'] ?? '',
      packOf: json['packOf'] ?? 1,
      unitCount: json['unitCount'] ?? 1,
      unitName: json['unitName'] ?? '',
      fragile: json['fragile'] ?? false,
      temperatureControlled: json['temperatureControlled'] ?? false,
      rating: RatingModel.fromJson(json['rating'] ?? {}),
      status: json['status'] ?? '',
      approvedBy: json['approvedBy'] ?? '',
      approvedAt: json['approvedAt'] ?? '',
      deletedAt: json['deletedAt'],
      deletedBy: json['deletedBy'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
      stock: json['stock'] ?? 0,
      reviews: List<dynamic>.from(json['reviews'] ?? []),
    );
  }
}