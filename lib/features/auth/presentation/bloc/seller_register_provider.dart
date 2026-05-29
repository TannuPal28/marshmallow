import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:marshmallow/core/network/dio_client.dart';
import 'package:marshmallow/core/utils/utils.dart';
import 'package:marshmallow/features/auth/data/datasources/seller_register_remote_datasource.dart';
import 'package:marshmallow/features/auth/data/repositories/seller_register_repository.dart';

class SellerRegisterProvider extends ChangeNotifier {
  final respository = SellerRegisterRepository(
    SellerRegisterRemoteDatasource(DioClient()),
  );

  //Basic info
  final businessNameController = TextEditingController();
  final ownerNameController = TextEditingController();
  final legalNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final mobileController = TextEditingController();
  final alternateMobileController = TextEditingController();
  final alternateEmailController = TextEditingController();

  //Address

  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final landmarkController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();
  final countryController = TextEditingController();
  final addressPhoneController = TextEditingController();
  final addressEmailController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  //Tax
  final panController = TextEditingController();
  final gstController = TextEditingController();
  final taxIdController = TextEditingController();
  final businessRegController = TextEditingController();
  final cinController = TextEditingController();
  final tanController = TextEditingController();
  final incorporationDateController = TextEditingController();

  /// BANK

  final accountHolderController = TextEditingController();
  final accountNumberController = TextEditingController();
  final ifscController = TextEditingController();
  final swiftController = TextEditingController();
  final bankNameController = TextEditingController();
  final branchController = TextEditingController();
  final branchCodeController = TextEditingController();
  bool isLoading = false;
  String businessType = "individual";
  List<String> businessTypeList = [
    "individual",
    "sole_proprietorship",
    "partnership",
    "company",
    "limited_liability_partnership",
    "other",
  ];
  String accountType = "savings";
  File? cancelledCheque;
  File? gstCertificate;
  File? panCardCopy;
  List<File> kycDocuments = [];
  List<File> taxDocs = [];

  //validation
  bool validateBasicInfo(BuildContext context) {
    if (businessNameController.text.trim().isEmpty) {
      Utils.showMessage(context, "Enter business name");
      return false;
    }
    if (ownerNameController.text.trim().isEmpty) {
      Utils.showMessage(context, "Enter owner name");
      return false;
    }

    if (emailController.text.trim().isEmpty) {
      Utils.showMessage(context, "Enter email");
      return false;
    }

    if (!Utils.isValidEmail(emailController.text.trim())) {
      Utils.showMessage(context, "Enter valid email");
      return false;
    }

    if (!Utils.isValidMobile(mobileController.text.trim())) {
      Utils.showMessage(context, "Enter valid mobile number");
      return false;
    }

    if (!Utils.isValidPassword(passwordController.text.trim())) {
      Utils.showMessage(
        context,
        "Password must contain upper, lower, number & special character",
      );
      return false;
    }

    if (passwordController.text.length < 8) {
      Utils.showMessage(context, "Password must be 8 characters");
      return false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Utils.showMessage(context, "Password not matched");
      return false;
    }
    return true;
  }

  bool validateAddress(BuildContext context) {
    if (address1Controller.text.isEmpty) {
      Utils.showMessage(context, "Enter address line 1");
      return false;
    }

    if (cityController.text.isEmpty) {
      Utils.showMessage(context, "Enter city");
      return false;
    }

    if (stateController.text.isEmpty) {
      Utils.showMessage(context, "Enter state");
      return false;
    }

    if (pincodeController.text.length != 6) {
      Utils.showMessage(context, "Enter valid pincode");
      return false;
    }

    return true;
  }

  bool validateTax(BuildContext context) {
    if (panController.text.isEmpty) {
      Utils.showMessage(context, "Enter PAN");
      return false;
    }

    if (gstController.text.isEmpty) {
      Utils.showMessage(context, "Enter GST");
      return false;
    }

    if (!Utils.isValidPan(panController.text.trim())) {
      Utils.showMessage(context, "Enter valid PAN");
      return false;
    }

    if (!Utils.isValidGst(gstController.text.trim())) {
      Utils.showMessage(context, "Enter valid GST");
      return false;
    }

    return true;
  }

  bool validateBank(BuildContext context) {
    print("Cancelled Cheque provider=> $cancelledCheque");
    if (accountHolderController.text.isEmpty) {
      Utils.showMessage(context, "Enter account holder");
      return false;
    }

    if (accountNumberController.text.isEmpty) {
      Utils.showMessage(context, "Enter account number");
      return false;
    }

    if (ifscController.text.isEmpty) {
      Utils.showMessage(context, "Enter IFSC");
      return false;
    }
    if (!Utils.isValidIfsc(ifscController.text.trim())) {
      Utils.showMessage(context, "Enter valid IFSC");
      return false;
    }

    if (cancelledCheque == null) {
      Utils.showMessage(context, "Upload cancelled cheque");
      return false;
    }

    return true;
  }

  //api

  Future<bool> registerSeller(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      FormData formData = FormData.fromMap({
        // BASIC INFO
        "businessName": businessNameController.text,
        "userName": ownerNameController.text,
        "ownerName": ownerNameController.text,
        "legalName": legalNameController.text,
        "businessType": businessType,
        "email": emailController.text,
        "password": passwordController.text,
        "mobile": mobileController.text,
        "alternateMobile": alternateMobileController.text,
        "alternateEmail": alternateEmailController.text,
        "countryCode": "+91",

        // CUSTOM FIELDS
        "customBusinessFields": jsonEncode([
          {"key": "businessCategory", "value": "general"},
          {"key": "applicationSource", "value": "web_form"},
        ]),

        // ADDRESS
        "businessAddress": jsonEncode({
          "label": "Head Office",
          "addressLine1": address1Controller.text,
          "addressLine2": address2Controller.text,
          "city": cityController.text,
          "state": stateController.text,
          "country": countryController.text,
          "pinCode": pincodeController.text,
          "landmark": landmarkController.text,
          "phone": addressPhoneController.text,
          "email": addressEmailController.text,
          "location": {
            "type": "Point",
            "coordinates": [
              double.tryParse(longitudeController.text) ?? 0.0,
              double.tryParse(latitudeController.text) ?? 0.0,
            ],
          },
          "isPrimary": true,
        }),

        // TAX
        "tax": jsonEncode({
          "governmentId": panController.text,
          "gstNumber": gstController.text,
          "taxId": taxIdController.text,
          "businessRegistrationNumber": businessRegController.text,
          "CIN": cinController.text,
          "TAN": tanController.text,
          "dateOfIncorporation": incorporationDateController.text,
        }),

        // BANK
        "bankDetails": jsonEncode({
          "accountHolderName": accountHolderController.text,
          "accountNumber": accountNumberController.text,
          "ifsc": ifscController.text,
          "swift": swiftController.text,
          "bankName": bankNameController.text,
          "branch": branchController.text,
          "bankAccountType": accountType,
          "branchCode": branchCodeController.text,
          "payoutMethod": "bank_transfer",
          "verified": false,
        }),

        // METADATA
        "metadata": jsonEncode([
          {
            "key": "registrationDate",
            "value": DateTime.now().toIso8601String(),
          },
          {"key": "applicationStatus", "value": "pending"},
        ]),

        // CANCELLED CHEQUE
        "cancelledCheque": await MultipartFile.fromFile(cancelledCheque!.path),

        // KYC DOCS
        "kycDocuments": await Future.wait(
          kycDocuments.map((e) async => await MultipartFile.fromFile(e.path)),
        ),

        // TAX DOCS
        "taxDocs": await Future.wait([
          if (gstCertificate != null)
            MultipartFile.fromFile(gstCertificate!.path),

          if (panCardCopy != null) MultipartFile.fromFile(panCardCopy!.path),
        ]),
      });

      print(formData.fields);
      print(formData.files);

      final response = await respository.sellerRegister(formData: formData);

      Utils.showMessage(context, response.message ?? "");
      return true;
    } catch (e) {
      print("ERROR => $e");

      if (e is DioException) {
        print(e.response?.data);

        Utils.showMessage(
          context,
          e.response?.data["message"] ?? "Something went wrong",
        );
      } else {
        Utils.showMessage(context, e.toString());
      }
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    businessNameController.dispose();
    ownerNameController.dispose();
    legalNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    mobileController.dispose();
    alternateMobileController.dispose();
    alternateEmailController.dispose();

    address1Controller.dispose();
    address2Controller.dispose();
    landmarkController.dispose();
    cityController.dispose();
    stateController.dispose();
    pincodeController.dispose();
    countryController.dispose();
    addressPhoneController.dispose();
    addressEmailController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();

    panController.dispose();
    gstController.dispose();
    taxIdController.dispose();
    businessRegController.dispose();
    cinController.dispose();
    tanController.dispose();

    accountHolderController.dispose();
    accountNumberController.dispose();
    ifscController.dispose();
    swiftController.dispose();
    bankNameController.dispose();
    branchController.dispose();
    branchCodeController.dispose();

    super.dispose();
  }
}
