class AddToCartResponseModel {

  final bool success;
  final String message;

  AddToCartResponseModel({
    required this.success,
    required this.message,
  });

  factory AddToCartResponseModel.fromJson(
      Map<String, dynamic> json,
      ) {

    return AddToCartResponseModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
    );
  }
}