class AddAddressRequest {
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
  final String pinCode;
  final String addressType;
  final String floor;
  final String howToReach;
  final bool defaultAddress;

  AddAddressRequest({
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
    required this.pinCode,
    required this.addressType,
    required this.floor,
    required this.howToReach,
    required this.defaultAddress,
  });

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "phone": phone,
    "email": email,
    "line1": line1,
    "line2": line2,
    "landmark": landmark,
    "area": area,
    "city": city,
    "state": state,
    "country": country,
    "postalCode": postalCode,
    "pinCode": pinCode,
    "addressType": addressType.toLowerCase(),
    "floor": floor,
    "howToReach": howToReach,
    "defaultAddress": defaultAddress,
  };
}