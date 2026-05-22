import 'package:marshmallow/features/home/data/datasources/product_remote_datasource.dart';
import 'package:marshmallow/features/home/data/models/product_model.dart';

class ProductRepository {
  final ProductRemoteDatasource remoteDatasource;
  ProductRepository(this.remoteDatasource);

  Future<List<ProductItem>> getProducts({
    required int page,
    required int pageSize,
}) async{
    return await remoteDatasource.getProducts(page: page, pageSize: pageSize);
  }
}