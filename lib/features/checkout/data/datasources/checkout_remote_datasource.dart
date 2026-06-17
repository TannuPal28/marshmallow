import 'package:dio/dio.dart';
import 'package:marshmallow/core/network/api_constants.dart';
import 'package:marshmallow/core/network/dio_client.dart';
import 'package:marshmallow/features/checkout/data/models/add_address_request_model.dart';
import 'package:marshmallow/features/checkout/data/models/address_model.dart';
import 'package:marshmallow/features/checkout/data/models/coupon_response.dart';

class CheckoutRemoteDatasource {
  final DioClient dioClient;

  CheckoutRemoteDatasource(this.dioClient);

  Future<AddressResponse> getAddressList() async {
    try {
      final response = await dioClient.get(ApiConstants.getAddress);
      return AddressResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to load addresses",
      );
    }
  }

  Future<CouponResponse> getActiveCoupons() async{
    try{
      final response= await dioClient.get(ApiConstants.getCoupons);
      return CouponResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ??
            "Failed to load coupons",
      );
    }
  }

  Future<void> addAddress(AddAddressRequest request) async{
    try{
      await dioClient.post(ApiConstants.getAddress,
      data: request.toJson());
    }on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ??
            "Failed to add address",
      );
    }
  }
}
