import 'package:flutter/material.dart';
import 'package:marshmallow/features/home/data/datasources/category_remote_datasource.dart';
import 'package:marshmallow/features/home/data/datasources/product_remote_datasource.dart';
import 'package:marshmallow/features/home/data/repositories/category_repository.dart';
import 'package:marshmallow/features/home/data/repositories/product_repository.dart';
import 'package:marshmallow/features/home/presentation/bloc/category_provider.dart';
import 'package:marshmallow/features/home/presentation/bloc/product_provider.dart';
import 'package:provider/provider.dart';

import 'package:marshmallow/features/auth/presentation/pages/splash_page.dart';

import 'core/theme/app_theme.dart';
import 'core/network/dio_client.dart';

import 'features/auth/data/datasources/register_remote_datasource.dart';
import 'features/auth/data/repositories/register_repository.dart';
import 'features/auth/presentation/bloc/register_provider.dart';
import 'features/home/data/datasources/banner_remote_datasource.dart';
import 'features/home/data/repositories/banner_repository.dart';
import 'features/home/presentation/bloc/banner_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BannerProvider(
            BannerRepository(BannerRemoteDatasource(DioClient())),
          )..fetchBanners(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(
            CategoryRepository(CategoryRemoteDatasource(DioClient())),
          )..fetchCategories(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(
            ProductRepository(ProductRemoteDatasource(DioClient())),
          )..fetchProducts(),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterProvider(
            RegisterRepository(
              RegisterRemoteDatasource(
                DioClient(),
              ),
            ),
          ),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashPage(),
      ),
    );
  }
}
