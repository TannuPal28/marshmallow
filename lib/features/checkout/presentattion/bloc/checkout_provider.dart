import 'package:flutter/cupertino.dart';
import 'package:marshmallow/features/checkout/data/models/add_address_request_model.dart';
import 'package:marshmallow/features/checkout/data/models/address_model.dart';
import 'package:marshmallow/features/checkout/data/models/coupon_response.dart';
import 'package:marshmallow/features/checkout/data/repositories/checkout_repository.dart';

class CheckoutProvider extends ChangeNotifier {
  final CheckoutRepository repository;

  CheckoutProvider(this.repository);

  bool isLoading = false;
  bool isLoadingCoupons = false;
  bool isAddingAddress = false;
  AddressResponse? addressResponse;
  AddressItem? selectedAddress;

  CouponResponse? couponResponse;

  Future<void> fetchAddress() async {
    try {
      isLoading = true;
      notifyListeners();
      addressResponse = await repository.getAddressList();
      if (addressResponse!.results.isNotEmpty) {
        selectedAddress = addressResponse!.results.firstWhere(
          (e) => e.defaultAddress,
          orElse: () => addressResponse!.results.first,
        );
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCoupons() async {
    try {
      isLoadingCoupons = true;
      notifyListeners();

      couponResponse = await repository.getActiveCoupons();
    } finally {
      isLoadingCoupons = false;
      notifyListeners();
    }
  }

  Future<bool> addAddress(AddAddressRequest request) async {
    try {
      isAddingAddress = true;
      notifyListeners();
      await repository.addAddress(request);
      await fetchAddress();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      isAddingAddress = false;
      notifyListeners();
    }
  }

  void selectAddress(AddressItem address) {
    selectedAddress = address;
    notifyListeners();
  }
}
