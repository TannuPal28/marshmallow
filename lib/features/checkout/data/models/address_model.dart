class AddressResponse {
  final bool success;
  final String message;
  final List<AddressItem> results;

  AddressResponse({
    required this.success,
    required this.message,
    required this.results,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      results: (json["results"] as List?)
          ?.map((e) => AddressItem.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class AddressItem {
  final String id;
  final String fullName;
  final String phone;
  final String email;
  final String line1;
  final String line2;
  final String landmark;
  final String area;
  final String city;
  final String state;
  final String country;
  final String postalCode;
  final String addressType;
  final bool defaultAddress;

  AddressItem({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.line1,
    required this.line2,
    required this.landmark,
    required this.area,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    required this.addressType,
    required this.defaultAddress,
  });

  factory AddressItem.fromJson(Map<String, dynamic> json) {
    return AddressItem(
      id: json["_id"] ?? "",
      fullName: json["fullName"] ?? "",
      phone: json["phone"] ?? "",
      email: json["email"] ?? "",
      line1: json["line1"] ?? "",
      line2: json["line2"] ?? "",
      landmark: json["landmark"] ?? "",
      area: json["area"] ?? "",
      city: json["city"] ?? "",
      state: json["state"] ?? "",
      country: json["country"] ?? "",
      postalCode: json["postalCode"] ?? "",
      addressType: json["addressType"] ?? "",
      defaultAddress: json["defaultAddress"] ?? false,
    );
  }
}