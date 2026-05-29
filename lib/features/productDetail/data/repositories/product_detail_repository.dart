import 'package:marshmallow/features/home/data/datasources/product_remote_datasource.dart';
import 'package:marshmallow/features/productDetail/data/datasources/product_detail_remote_datasource.dart';
import 'package:marshmallow/features/productDetail/data/models/product_detail_model.dart';

class ProductDetailRepository {
  final ProductDetailRemoteDatasource productRemoteDatasource;

  ProductDetailRepository(this.productRemoteDatasource);

  Future<ProductDetailModel> productDetail(String productId) async{
    return await productRemoteDatasource.getDetail(productId);
  }
}