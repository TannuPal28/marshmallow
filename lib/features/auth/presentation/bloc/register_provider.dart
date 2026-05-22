import 'package:flutter/material.dart';
import 'package:marshmallow/features/auth/data/models/register_model.dart';
import 'package:marshmallow/features/auth/data/repositories/register_repository.dart';

class RegisterProvider extends ChangeNotifier{
  final RegisterRepository repository;
  RegisterProvider(this.repository);

  bool isLoading= false;
  RegisterModel? registerModel;
  String errorMessage = '';

  Future<RegisterModel?> register({
    required String fullName,
    required String email,
    required String mobile,
    required String password, required String countryCode,
})async {
    try{
      isLoading= true;
      notifyListeners();

      final response= await repository.register(fullName: fullName, email: email, mobile: mobile, password: password, countryCode: countryCode,);
      registerModel= response;
      return response;
    }catch (e) {

      errorMessage = e.toString();

    } finally {

      isLoading = false;

      notifyListeners();
    }
  }
}