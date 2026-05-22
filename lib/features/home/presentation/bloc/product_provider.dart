import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:marshmallow/features/home/data/models/product_model.dart';
import 'package:marshmallow/features/home/data/repositories/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepository repository;

  ProductProvider(this.repository);

  List<ProductItem> products = [];
  bool isLoading = false;
  bool isPaginationLoading = false;
  int currentPage = 1;

  final int pageSize = 10;

  bool hasMore = true;

  Future<void> fetchProducts({bool isLoadMore = false}) async {
    try {
      if (isPaginationLoading || !hasMore) {
        return;
      }

      if (!isLoadMore) {
        isLoading = true;
      } else {
        isPaginationLoading = true;
      }
      notifyListeners();
      final response = await repository.getProducts(
        page: currentPage,
        pageSize: pageSize,
      );

      if (response.length < pageSize) {
        hasMore = false;

        if (isLoadMore) {
          products.addAll(response);
        } else {
          products = response;
        }

        currentPage++;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;

      isPaginationLoading = false;

      notifyListeners();
    }
  }

  Future<void> refreshProducts() async {
    currentPage = 1;

    hasMore = true;

    products.clear();

    await fetchProducts();
  }
}
