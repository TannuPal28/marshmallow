import 'package:dio/dio.dart';
import 'package:marshmallow/core/network/api_constants.dart';
import 'package:marshmallow/core/network/dio_client.dart';
import 'package:marshmallow/features/home/data/models/category_model.dart';

class CategoryRemoteDatasource {
  final DioClient dioClient;

  CategoryRemoteDatasource(this.dioClient);

  Future<List<CategoryModel>> getCategories() async{
    try{
      final response= await dioClient.get(ApiConstants.categoryMenuList);
      final List data= response.data['results'];

      return data.map((e) => CategoryModel.fromJson(e)).toList();
    }on DioException catch (e) {

      throw Exception(e.message);
    }
  }
}