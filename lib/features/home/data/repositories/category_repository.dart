import 'package:marshmallow/features/home/data/datasources/category_remote_datasource.dart';
import 'package:marshmallow/features/home/data/models/category_model.dart';

class CategoryRepository {
  final CategoryRemoteDatasource remoteDatasource;

  CategoryRepository(this.remoteDatasource);

  Future<List<CategoryModel>> getCategories() async{
    return await remoteDatasource.getCategories();
  }
}