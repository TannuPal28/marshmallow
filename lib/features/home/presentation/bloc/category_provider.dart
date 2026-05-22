import 'package:flutter/cupertino.dart';
import 'package:marshmallow/features/home/data/models/category_model.dart';
import 'package:marshmallow/features/home/data/repositories/category_repository.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryRepository repository;

  CategoryProvider(this.repository);
  List<CategoryModel> categories= [];
  bool isLoading= false;

  Future<void> fetchCategories() async{
    try{
      isLoading= true;
      notifyListeners();
      categories= await repository.getCategories();
    }catch (e) {

      debugPrint(e.toString());

    } finally {

      isLoading = false;
      notifyListeners();
    }
  }

}
