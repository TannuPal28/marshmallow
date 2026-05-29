class LocationResponseModel {

  final String latitude;
  final String longitude;

  final String city;
  final String state;
  final String country;
  final String pincode;
  final String area;

  LocationResponseModel({
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
    required this.area,
  });

  factory LocationResponseModel.fromSearchJson(
      Map<String, dynamic> json,
      ) {

    return LocationResponseModel(
      latitude: json["lat"] ?? "",
      longitude: json["lon"] ?? "",
      city: json["display_name"] ?? "",
      state: "",
      country: "",
      pincode: "",
      area: "",
    );
  }

  factory LocationResponseModel.fromReverseJson(
      Map<String, dynamic> json,
      ) {

    final address = json["address"] ?? {};

    return LocationResponseModel(
      latitude: json["lat"] ?? "",
      longitude: json["lon"] ?? "",

      city:
      address["city"] ??
          address["town"] ??
          address["village"] ??
          "",

      state:
      address["state"] ?? "",

      country:
      address["country"] ?? "",

      pincode:
      address["postcode"] ?? "",

      area:
      address["suburb"] ??
          address["neighbourhood"] ??
          "",
    );
  }
}