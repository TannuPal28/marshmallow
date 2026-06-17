class CouponResponse {
  final bool success;
  final String message;
  final List<CouponItem> results;

  CouponResponse({
    required this.success,
    required this.message,
    required this.results,
  });

  factory CouponResponse.fromJson(Map<String, dynamic> json) {
    return CouponResponse(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      results: (json["results"] as List? ?? [])
          .map((e) => CouponItem.fromJson(e))
          .toList(),
    );
  }
}

class CouponItem {
  final String id;
  final String code;
  final String title;
  final String description;
  final String discount;

  CouponItem({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.discount,
  });

  factory CouponItem.fromJson(Map<String, dynamic> json) {
    return CouponItem(
      id: json["_id"]?.toString() ?? "",
      code: json["code"]?.toString() ?? "",
      title: json["title"]?.toString() ?? "",
      description: json["description"]?.toString() ?? "",
      discount: json["discount"]?.toString() ?? "",
    );
  }
}