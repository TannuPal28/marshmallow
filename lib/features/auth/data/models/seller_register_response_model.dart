class SellerRegisterResponseModel {
  final bool? success;
  final String? message;
  final SellerResult? results;

  SellerRegisterResponseModel({
    this.success,
    this.message,
    this.results,
  });

  factory SellerRegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return SellerRegisterResponseModel(
      success: json['success'],
      message: json['message'],
      results: json['results'] != null
          ? SellerResult.fromJson(json['results'])
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

class SellerResult {
  final String? id;
  final String? email;
  final String? role;
  final String? businessName;
  final String? ownerName;
  final String? legalName;
  final String? businessType;
  final String? mobile;
  final String? alternateMobile;
  final String? alternateEmail;
  final String? countryCode;
  final List<dynamic>? permission;
  final List<KeyValueModel>? customBusinessFields;
  final BusinessAddress? businessAddress;
  final TaxModel? tax;
  final BankDetailsModel? bankDetails;
  final List<dynamic>? kycDocuments;
  final StoreModel? store;
  final String? status;
  final bool? isPasswordSet;
  final bool? notification;
  final List<KeyValueModel>? metadata;
  final String? createdAt;
  final String? updatedAt;

  SellerResult({
    this.id,
    this.email,
    this.role,
    this.businessName,
    this.ownerName,
    this.legalName,
    this.businessType,
    this.mobile,
    this.alternateMobile,
    this.alternateEmail,
    this.countryCode,
    this.permission,
    this.customBusinessFields,
    this.businessAddress,
    this.tax,
    this.bankDetails,
    this.kycDocuments,
    this.store,
    this.status,
    this.isPasswordSet,
    this.notification,
    this.metadata,
    this.createdAt,
    this.updatedAt,
  });

  factory SellerResult.fromJson(Map<String, dynamic> json) {
    return SellerResult(
      id: json['_id'],
      email: json['email'],
      role: json['role'],
      businessName: json['businessName'],
      ownerName: json['ownerName'],
      legalName: json['legalName'],
      businessType: json['businessType'],
      mobile: json['mobile'],
      alternateMobile: json['alternateMobile'],
      alternateEmail: json['alternateEmail'],
      countryCode: json['countryCode'],
      permission: json['permission'],
      customBusinessFields: json['customBusinessFields'] != null
          ? List<KeyValueModel>.from(
        json['customBusinessFields']
            .map((x) => KeyValueModel.fromJson(x)),
      )
          : [],
      businessAddress: json['businessAddress'] != null
          ? BusinessAddress.fromJson(json['businessAddress'])
          : null,
      tax: json['tax'] != null
          ? TaxModel.fromJson(json['tax'])
          : null,
      bankDetails: json['bankDetails'] != null
          ? BankDetailsModel.fromJson(json['bankDetails'])
          : null,
      kycDocuments: json['kycDocuments'],
      store: json['store'] != null
          ? StoreModel.fromJson(json['store'])
          : null,
      status: json['status'],
      isPasswordSet: json['isPasswordSet'],
      notification: json['notification'],
      metadata: json['metadata'] != null
          ? List<KeyValueModel>.from(
        json['metadata']
            .map((x) => KeyValueModel.fromJson(x)),
      )
          : [],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "email": email,
      "role": role,
      "businessName": businessName,
      "ownerName": ownerName,
      "legalName": legalName,
      "businessType": businessType,
      "mobile": mobile,
      "alternateMobile": alternateMobile,
      "alternateEmail": alternateEmail,
      "countryCode": countryCode,
      "permission": permission,
      "customBusinessFields":
      customBusinessFields?.map((e) => e.toJson()).toList(),
      "businessAddress": businessAddress?.toJson(),
      "tax": tax?.toJson(),
      "bankDetails": bankDetails?.toJson(),
      "kycDocuments": kycDocuments,
      "store": store?.toJson(),
      "status": status,
      "isPasswordSet": isPasswordSet,
      "notification": notification,
      "metadata": metadata?.map((e) => e.toJson()).toList(),
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}

class KeyValueModel {
  final String? key;
  final String? value;

  KeyValueModel({
    this.key,
    this.value,
  });

  factory KeyValueModel.fromJson(Map<String, dynamic> json) {
    return KeyValueModel(
      key: json['key'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "key": key,
      "value": value,
    };
  }
}

class BusinessAddress {
  final String? label;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? state;
  final String? country;
  final String? pinCode;
  final String? landmark;
  final String? phone;
  final String? email;
  final LocationModel? location;
  final bool? isPrimary;

  BusinessAddress({
    this.label,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.country,
    this.pinCode,
    this.landmark,
    this.phone,
    this.email,
    this.location,
    this.isPrimary,
  });

  factory BusinessAddress.fromJson(Map<String, dynamic> json) {
    return BusinessAddress(
      label: json['label'],
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      pinCode: json['pinCode'],
      landmark: json['landmark'],
      phone: json['phone'],
      email: json['email'],
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      isPrimary: json['isPrimary'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "label": label,
      "addressLine1": addressLine1,
      "addressLine2": addressLine2,
      "city": city,
      "state": state,
      "country": country,
      "pinCode": pinCode,
      "landmark": landmark,
      "phone": phone,
      "email": email,
      "location": location?.toJson(),
      "isPrimary": isPrimary,
    };
  }
}

class LocationModel {
  final String? type;
  final List<double>? coordinates;

  LocationModel({
    this.type,
    this.coordinates,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      type: json['type'],
      coordinates: json['coordinates'] != null
          ? List<double>.from(
        json['coordinates'].map((x) => x.toDouble()),
      )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "coordinates": coordinates,
    };
  }
}

class TaxModel {
  final String? governmentId;
  final String? gstNumber;
  final String? taxId;
  final String? businessRegistrationNumber;
  final String? cin;
  final String? tan;
  final String? dateOfIncorporation;
  final List<dynamic>? taxDocs;

  TaxModel({
    this.governmentId,
    this.gstNumber,
    this.taxId,
    this.businessRegistrationNumber,
    this.cin,
    this.tan,
    this.dateOfIncorporation,
    this.taxDocs,
  });

  factory TaxModel.fromJson(Map<String, dynamic> json) {
    return TaxModel(
      governmentId: json['governmentId'],
      gstNumber: json['gstNumber'],
      taxId: json['taxId'],
      businessRegistrationNumber:
      json['businessRegistrationNumber'],
      cin: json['CIN'],
      tan: json['TAN'],
      dateOfIncorporation: json['dateOfIncorporation'],
      taxDocs: json['taxDocs'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "governmentId": governmentId,
      "gstNumber": gstNumber,
      "taxId": taxId,
      "businessRegistrationNumber":
      businessRegistrationNumber,
      "CIN": cin,
      "TAN": tan,
      "dateOfIncorporation": dateOfIncorporation,
      "taxDocs": taxDocs,
    };
  }
}

class BankDetailsModel {
  final String? accountHolderName;
  final String? accountNumber;
  final String? ifsc;
  final String? swift;
  final String? bankName;
  final String? branch;
  final String? bankAccountType;
  final String? branchCode;
  final String? payoutMethod;
  final String? cancelledCheque;
  final bool? verified;

  BankDetailsModel({
    this.accountHolderName,
    this.accountNumber,
    this.ifsc,
    this.swift,
    this.bankName,
    this.branch,
    this.bankAccountType,
    this.branchCode,
    this.payoutMethod,
    this.cancelledCheque,
    this.verified,
  });

  factory BankDetailsModel.fromJson(Map<String, dynamic> json) {
    return BankDetailsModel(
      accountHolderName: json['accountHolderName'],
      accountNumber: json['accountNumber'],
      ifsc: json['ifsc'],
      swift: json['swift'],
      bankName: json['bankName'],
      branch: json['branch'],
      bankAccountType: json['bankAccountType'],
      branchCode: json['branchCode'],
      payoutMethod: json['payoutMethod'],
      cancelledCheque: json['cancelledCheque'],
      verified: json['verified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "accountHolderName": accountHolderName,
      "accountNumber": accountNumber,
      "ifsc": ifsc,
      "swift": swift,
      "bankName": bankName,
      "branch": branch,
      "bankAccountType": bankAccountType,
      "branchCode": branchCode,
      "payoutMethod": payoutMethod,
      "cancelledCheque": cancelledCheque,
      "verified": verified,
    };
  }
}

class StoreModel {
  final String? storeLogo;
  final String? storeBanner;
  final String? storeDescription;
  final String? storeTagline;
  final String? returnPolicy;
  final String? shippingPolicy;
  final String? supportEmail;
  final String? supportPhone;
  final String? supportTimings;
  final List<dynamic>? brandList;
  final List<dynamic>? categoryPreferences;
  final String? fulfillmentType;
  final List<dynamic>? additionalDocuments;
  final SocialLinksModel? socialLinks;

  StoreModel({
    this.storeLogo,
    this.storeBanner,
    this.storeDescription,
    this.storeTagline,
    this.returnPolicy,
    this.shippingPolicy,
    this.supportEmail,
    this.supportPhone,
    this.supportTimings,
    this.brandList,
    this.categoryPreferences,
    this.fulfillmentType,
    this.additionalDocuments,
    this.socialLinks,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      storeLogo: json['storeLogo'],
      storeBanner: json['storeBanner'],
      storeDescription: json['storeDescription'],
      storeTagline: json['storeTagline'],
      returnPolicy: json['returnPolicy'],
      shippingPolicy: json['shippingPolicy'],
      supportEmail: json['supportEmail'],
      supportPhone: json['supportPhone'],
      supportTimings: json['supportTimings'],
      brandList: json['brandList'],
      categoryPreferences: json['categoryPreferences'],
      fulfillmentType: json['fulfillmentType'],
      additionalDocuments: json['additionalDocuments'],
      socialLinks: json['socialLinks'] != null
          ? SocialLinksModel.fromJson(json['socialLinks'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "storeLogo": storeLogo,
      "storeBanner": storeBanner,
      "storeDescription": storeDescription,
      "storeTagline": storeTagline,
      "returnPolicy": returnPolicy,
      "shippingPolicy": shippingPolicy,
      "supportEmail": supportEmail,
      "supportPhone": supportPhone,
      "supportTimings": supportTimings,
      "brandList": brandList,
      "categoryPreferences": categoryPreferences,
      "fulfillmentType": fulfillmentType,
      "additionalDocuments": additionalDocuments,
      "socialLinks": socialLinks?.toJson(),
    };
  }
}

class SocialLinksModel {
  final String? instagram;
  final String? facebook;
  final String? youtube;
  final String? tiktok;
  final String? website;

  SocialLinksModel({
    this.instagram,
    this.facebook,
    this.youtube,
    this.tiktok,
    this.website,
  });

  factory SocialLinksModel.fromJson(Map<String, dynamic> json) {
    return SocialLinksModel(
      instagram: json['instagram'],
      facebook: json['facebook'],
      youtube: json['youtube'],
      tiktok: json['tiktok'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "instagram": instagram,
      "facebook": facebook,
      "youtube": youtube,
      "tiktok": tiktok,
      "website": website,
    };
  }
}
