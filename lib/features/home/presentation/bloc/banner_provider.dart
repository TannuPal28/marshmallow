import 'package:flutter/cupertino.dart';
import 'package:marshmallow/features/home/data/models/banner_model.dart';
import 'package:marshmallow/features/home/data/repositories/banner_repository.dart';

class BannerProvider extends ChangeNotifier {
  final BannerRepository repository;

  BannerProvider(this.repository);

  List<BannerModel> banners= [];
  bool isLoading= false;

  Future<void> fetchBanners() async{
    try{
      isLoading= true;
      notifyListeners();
      banners= await repository.getBanners();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}