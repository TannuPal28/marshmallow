class VerifyOtpResponseModel {
  bool? success;
  String? message;
  Results? results;

  VerifyOtpResponseModel({
    this.success,
    this.message,
    this.results,
  });

  VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];

    results = json['results'] != null
        ? Results.fromJson(json['results'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "results": results?.toJson(),
    };
  }
}

class Results {
  String? id;
  String? firstName;
  String? lastName;
  String? fullName;
  String? countryCode;
  String? mobile;
  String? email;
  String? googleId;
  String? role;
  int? isMobileVerified;
  int? isEmailVerified;
  String? profilePic;
  String? status;
  bool? isDeleted;
  String? password;
  dynamic deviceId;
  dynamic deviceType;
  dynamic deviceToken;
  String? registrationType;
  dynamic rating;
  dynamic socialId;
  bool? notifications;
  bool? forceLogout;
  List<dynamic>? address;
  String? createdAt;
  String? updatedAt;
  int? v;

  String? token;
  String? refreshToken;

  Results({
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.countryCode,
    this.mobile,
    this.email,
    this.googleId,
    this.role,
    this.isMobileVerified,
    this.isEmailVerified,
    this.profilePic,
    this.status,
    this.isDeleted,
    this.password,
    this.deviceId,
    this.deviceType,
    this.deviceToken,
    this.registrationType,
    this.rating,
    this.socialId,
    this.notifications,
    this.forceLogout,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.token,
    this.refreshToken,
  });

  Results.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    countryCode = json['countryCode'];
    mobile = json['mobile'];
    email = json['email'];
    googleId = json['googleId'];
    role = json['role'];
    isMobileVerified = json['isMobileVerified'];
    isEmailVerified = json['isEmailVerified'];
    profilePic = json['profilePic'];
    status = json['status'];
    isDeleted = json['isDeleted'];
    password = json['password'];
    deviceId = json['deviceId'];
    deviceType = json['deviceType'];
    deviceToken = json['deviceToken'];
    registrationType = json['registrationType'];
    rating = json['rating'];
    socialId = json['socialId'];
    notifications = json['notifications'];
    forceLogout = json['forceLogout'];
    address = json['address'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];

    token = json['token'];
    refreshToken = json['refreshToken'];
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
      "isMobileVerified": isMobileVerified,
      "isEmailVerified": isEmailVerified,
      "profilePic": profilePic,
      "status": status,
      "isDeleted": isDeleted,
      "password": password,
      "deviceId": deviceId,
      "deviceType": deviceType,
      "deviceToken": deviceToken,
      "registrationType": registrationType,
      "rating": rating,
      "socialId": socialId,
      "notifications": notifications,
      "forceLogout": forceLogout,
      "address": address,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "__v": v,
      "token": token,
      "refreshToken": refreshToken,
    };
  }
}