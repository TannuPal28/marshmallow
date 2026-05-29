class LoginResponseModel {

  final bool success;
  final String message;
  final LoginResults? results;

  LoginResponseModel({
    required this.success,
    required this.message,
    this.results,
  });

  factory LoginResponseModel.fromJson(
      Map<String, dynamic> json) {

    return LoginResponseModel(
      success: json["success"] ?? false,

      message: json["message"] ?? "",

      results: json["results"] != null
          ? LoginResults.fromJson(
        json["results"],
      )
          : null,
    );
  }

  Map<String, dynamic> toJson() {

    return {

      "success": success,

      "message": message,

      "results": results?.toJson(),
    };
  }
}

class LoginResults {

  final String id;

  final String firstName;

  final String lastName;

  final String fullName;

  final String countryCode;

  final String mobile;

  final String email;

  final dynamic googleId;

  final String role;

  final int isMobileVerified;

  final int isEmailVerified;

  final String profilePic;

  final String status;

  final bool isDeleted;

  final String registrationType;

  final dynamic rating;

  final dynamic socialId;

  final bool notifications;

  final bool forceLogout;

  final List<dynamic> address;

  final String createdAt;

  final String updatedAt;

  final String token;

  final String refreshToken;

  LoginResults({

    required this.id,

    required this.firstName,

    required this.lastName,

    required this.fullName,

    required this.countryCode,

    required this.mobile,

    required this.email,

    required this.googleId,

    required this.role,

    required this.isMobileVerified,

    required this.isEmailVerified,

    required this.profilePic,

    required this.status,

    required this.isDeleted,

    required this.registrationType,

    required this.rating,

    required this.socialId,

    required this.notifications,

    required this.forceLogout,

    required this.address,

    required this.createdAt,

    required this.updatedAt,

    required this.token,

    required this.refreshToken,
  });

  factory LoginResults.fromJson(
      Map<String, dynamic> json) {

    return LoginResults(

      id: json["_id"] ?? "",

      firstName:
      json["firstName"] ?? "",

      lastName:
      json["lastName"] ?? "",

      fullName:
      json["fullName"] ?? "",

      countryCode:
      json["countryCode"] ?? "",

      mobile:
      json["mobile"] ?? "",

      email:
      json["email"] ?? "",

      googleId:
      json["googleId"],

      role:
      json["role"] ?? "",

      isMobileVerified:
      json["isMobileVerified"] ?? 0,

      isEmailVerified:
      json["isEmailVerified"] ?? 0,

      profilePic:
      json["profilePic"] ?? "",

      status:
      json["status"] ?? "",

      isDeleted:
      json["isDeleted"] ?? false,

      registrationType:
      json["registrationType"] ?? "",

      rating:
      json["rating"],

      socialId:
      json["socialId"],

      notifications:
      json["notifications"] ?? false,

      forceLogout:
      json["forceLogout"] ?? false,

      address:
      json["address"] ?? [],

      createdAt:
      json["createdAt"] ?? "",

      updatedAt:
      json["updatedAt"] ?? "",

      token:
      json["token"] ?? "",

      refreshToken:
      json["refreshToken"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {

    return {

      "_id": id,

      "firstName": firstName,

      "lastName": lastName,

      "fullName": fullName,

      "countryCode": countryCode,

      "mobile": mobile,

      "email": email,

      "googleId": googleId,

      "role": role,

      "isMobileVerified":
      isMobileVerified,

      "isEmailVerified":
      isEmailVerified,

      "profilePic": profilePic,

      "status": status,

      "isDeleted": isDeleted,

      "registrationType":
      registrationType,

      "rating": rating,

      "socialId": socialId,

      "notifications":
      notifications,

      "forceLogout":
      forceLogout,

      "address": address,

      "createdAt": createdAt,

      "updatedAt": updatedAt,

      "token": token,

      "refreshToken":
      refreshToken,
    };
  }
}