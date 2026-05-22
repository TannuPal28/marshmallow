class RegisterModel {
  final bool success;
  final String message;
  final RegisterUser results;

  RegisterModel({
    required this.success,
    required this.message,
    required this.results,
  });

  factory RegisterModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return RegisterModel(
      success: json['success'] ?? false,

      message: json['message'] ?? '',

      results: RegisterUser.fromJson(
        json['results'] ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "results": results.toJson(),
    };
  }
}

class RegisterUser {
  final String id;

  final String firstName;
  final String lastName;
  final String fullName;

  final String countryCode;

  final String mobile;

  final String email;

  final String password;

  final int isMobileVerified;

  final int isEmailVerified;

  final String status;

  final dynamic deviceId;
  final dynamic deviceType;
  final dynamic deviceToken;

  final String registrationType;

  final bool notifications;

  final String profilePic;

  final String mobileOtpId;

  final String emailOtpId;

  final String createdAt;

  final String updatedAt;

  final int v;

  RegisterUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.countryCode,
    required this.mobile,
    required this.email,
    required this.password,
    required this.isMobileVerified,
    required this.isEmailVerified,
    required this.status,
    required this.deviceId,
    required this.deviceType,
    required this.deviceToken,
    required this.registrationType,
    required this.notifications,
    required this.profilePic,
    required this.mobileOtpId,
    required this.emailOtpId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory RegisterUser.fromJson(
      Map<String, dynamic> json,
      ) {
    return RegisterUser(
      id: json['_id'] ?? '',

      firstName: json['firstName'] ?? '',

      lastName: json['lastName'] ?? '',

      fullName: json['fullName'] ?? '',

      countryCode: json['countryCode'] ?? '',

      mobile: json['mobile'] ?? '',

      email: json['email'] ?? '',

      password: json['password'] ?? '',

      isMobileVerified:
      json['isMobileVerified'] ?? 0,

      isEmailVerified:
      json['isEmailVerified'] ?? 0,

      status: json['status'] ?? '',

      deviceId: json['deviceId'],

      deviceType: json['deviceType'],

      deviceToken: json['deviceToken'],

      registrationType:
      json['registrationType'] ?? '',

      notifications:
      json['notifications'] ?? false,

      profilePic: json['profilePic'] ?? '',

      mobileOtpId:
      json['mobileOtpId'] ?? '',

      emailOtpId:
      json['emailOtpId'] ?? '',

      createdAt: json['createdAt'] ?? '',

      updatedAt: json['updatedAt'] ?? '',

      v: json['__v'] ?? 0,
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
      "password": password,
      "isMobileVerified": isMobileVerified,
      "isEmailVerified": isEmailVerified,
      "status": status,
      "deviceId": deviceId,
      "deviceType": deviceType,
      "deviceToken": deviceToken,
      "registrationType": registrationType,
      "notifications": notifications,
      "profilePic": profilePic,
      "mobileOtpId": mobileOtpId,
      "emailOtpId": emailOtpId,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "__v": v,
    };
  }
}