import 'package:flutter/material.dart';
import '../../data/models/product_detail_model.dart';
import '../../data/repositories/product_detail_repository.dart';

// स्क्रीन के अनुसार स्टेटस इनम (Enum)
enum ProductStatus { loading, loaded, error }

class ProductDetailProvider extends ChangeNotifier {
  final ProductDetailRepository repository;

  ProductDetailModel? _product;
  VariantModel? _selectedVariant;
  ProductStatus _status = ProductStatus.loading;
  String _errorMessage = '';

  ProductDetailModel? get product => _product;
  VariantModel? get selectedVariant => _selectedVariant;
  ProductStatus get status => _status;
  String get errorMessage => _errorMessage;

  ProductDetailProvider(this.repository);

  Future<void> fetchProduct(String productId) async {
    _status = ProductStatus.loading;
    _errorMessage = '';
    _product = null;
    _selectedVariant = null;
    notifyListeners();

    try {
      final response = await repository.productDetail(productId);

      if (response != null) {
        _product = response;

        // डिफ़ॉल्ट रूप से पहला वेरिएंट चुनें
        if (_product!.variants.isNotEmpty) {
          _selectedVariant = _product!.variants.first;
        }

        // जब डेटा पूरी तरह आ जाए, तभी loaded सेट करें
        _status = ProductStatus.loaded;
      } else {
        _status = ProductStatus.error;
        _errorMessage = "Product response is empty from server.";
      }
    } catch (e) {
      _status = ProductStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      debugPrint("API PARSING ERROR: $e");
    }

    notifyListeners();
  }

  void selectVariant(String colorValue) {
    if (_product != null && _product!.variants.isNotEmpty) {
      try {
        _selectedVariant = _product!.variants.firstWhere(
              (v) => v.attributes.any(
                  (attr) => attr.name.toLowerCase() == 'color' &&
                  attr.value.toLowerCase() == colorValue.toLowerCase()
          ),
        );
      } catch (e) {
        _selectedVariant = _product!.variants.first;
      }
      notifyListeners();
    }
  }
}