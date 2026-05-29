import 'package:flutter/cupertino.dart';
import 'package:marshmallow/features/auth/data/models/verify_otp_response_model.dart';
import 'package:marshmallow/features/auth/data/repositories/verify_otp_repository.dart';

class VerifyOtpProvider extends ChangeNotifier{
  final VerifyOtpRepository repository;
  VerifyOtpProvider(this.repository);

  bool isLoading= false;
  VerifyOtpResponseModel? verifyOtpResponseModel;
  String errorMessage= "";

  Future<VerifyOtpResponseModel?> verifyOTP({
    required bool fromLogin,
    required int? otpMobile,
    required int? otpEmail,
    required String mobile,
    required String email,
  }) async {
    try{
      isLoading= true;
      notifyListeners();
      final response= await repository.verifyOTP(fromLogin: fromLogin,otpMobile: otpMobile, otpEmail: otpEmail, mobile: mobile, email: email);
      verifyOtpResponseModel= response;
      return response;
    }
    catch (e) {

      errorMessage = e.toString();

    } finally {

      isLoading = false;

      notifyListeners();
    }
  }
}