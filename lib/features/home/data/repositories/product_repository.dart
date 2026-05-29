import 'package:marshmallow/features/home/data/datasources/product_remote_datasource.dart';
import 'package:marshmallow/features/home/data/models/product_model.dart';
import 'package:marshmallow/features/home/data/models/similar_product_model.dart';

class ProductRepository {
  final ProductRemoteDatasource remoteDatasource;

  ProductRepository(this.remoteDatasource);

  Future<List<ProductItem>> getProducts({
    required int page,
    required int pageSize,
  }) async {
    return await remoteDatasource.getProducts(page: page, pageSize: pageSize);
  }

  Future<List<SimilarProductItem>> getSimilarProducts({
    required String categoryId,
    required String productId,
  }) async {
    return await remoteDatasource.getSimilarProducts(
      categoryId: categoryId,
      productId: productId,
    );
  }
}
