import 'package:marshmallow/features/home/data/datasources/banner_remote_datasource.dart';
import 'package:marshmallow/features/home/data/models/banner_model.dart';

class BannerRepository {
  final BannerRemoteDatasource bannerRemoteDatasource;


  BannerRepository(this.bannerRemoteDatasource);

  Future<List<BannerModel>> getBanners() async{
    return await bannerRemoteDatasource.getBanners();
  }
}