  import 'package:marshmallow/features/checkout/data/datasources/checkout_remote_datasource.dart';
import 'package:marshmallow/features/checkout/data/models/add_address_request_model.dart';
  import 'package:marshmallow/features/checkout/data/models/address_model.dart';
import 'package:marshmallow/features/checkout/data/models/coupon_response.dart';

  class CheckoutRepository {
    final CheckoutRemoteDatasource remoteDatasource;
    CheckoutRepository(this.remoteDatasource);

    Future<AddressResponse> getAddressList(){
      return remoteDatasource.getAddressList();
    }

    Future<CouponResponse> getActiveCoupons(){
      return remoteDatasource.getActiveCoupons();
    }

    Future<void> addAddress(AddAddressRequest request){
      return remoteDatasource.addAddress(request);
    }
  }