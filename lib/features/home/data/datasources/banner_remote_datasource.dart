import 'package:dio/dio.dart';
import 'package:marshmallow/core/network/api_constants.dart';
import 'package:marshmallow/core/network/dio_client.dart';
import 'package:marshmallow/features/home/data/models/banner_model.dart';

class BannerRemoteDatasource {
  final DioClient dioClient;

  BannerRemoteDatasource(this.dioClient);

  Future<List<BannerModel>> getBanners() async{
    try{
      final response= await dioClient.get(ApiConstants.bannerList);
      final List docs= response.data['results']['docs'];

      return docs.map((e) => BannerModel.fromJson(e)).toList();
    }on DioException catch(e){
      throw Exception(e.message);
    }
  }
}