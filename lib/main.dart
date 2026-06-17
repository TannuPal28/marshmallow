import 'package:flutter/material.dart';
import 'package:marshmallow/features/auth/data/datasources/verify_remote_otp_datasource.dart';
import 'package:marshmallow/features/auth/data/repositories/verify_forgot_password_otp_repository.dart';
import 'package:marshmallow/features/auth/data/repositories/verify_otp_repository.dart';
import 'package:marshmallow/features/auth/presentation/bloc/verify_forgot_password_otp_provider.dart';
import 'package:marshmallow/features/auth/presentation/bloc/verify_otp_provider.dart';
import 'package:marshmallow/features/checkout/data/datasources/checkout_remote_datasource.dart';
import 'package:marshmallow/features/checkout/data/repositories/checkout_repository.dart';
import 'package:marshmallow/features/checkout/presentattion/bloc/checkout_provider.dart';
import 'package:marshmallow/features/home/data/datasources/category_remote_datasource.dart';
import 'package:marshmallow/features/home/data/datasources/product_remote_datasource.dart';
import 'package:marshmallow/features/home/data/repositories/category_repository.dart';
import 'package:marshmallow/features/home/data/repositories/product_repository.dart';
import 'package:marshmallow/features/home/presentation/bloc/category_provider.dart';
import 'package:marshmallow/features/home/presentation/bloc/product_provider.dart';
import 'package:marshmallow/features/productDetail/data/datasources/add_to_cart_remote_datasource.dart';
import 'package:marshmallow/features/productDetail/data/datasources/product_detail_remote_datasource.dart';
import 'package:marshmallow/features/productDetail/data/repositories/add_to_cart_repository.dart';
import 'package:marshmallow/features/productDetail/data/repositories/product_detail_repository.dart';
import 'package:marshmallow/features/productDetail/presentation/bloc/add_to_cart_provider.dart';
import 'package:marshmallow/features/productDetail/presentation/bloc/product_detail_provider.dart';
import 'package:provider/provider.dart';

import 'package:marshmallow/features/auth/presentation/pages/splash_page.dart';

import 'core/theme/app_theme.dart';
import 'core/network/dio_client.dart';

import 'features/auth/data/datasources/login_remote_datasource.dart';
import 'features/auth/data/datasources/register_remote_datasource.dart';
import 'features/auth/data/datasources/reset_password_remote_datasource.dart';
import 'features/auth/data/datasources/verify_forgot_password_otp_datasource.dart';
import 'features/auth/data/repositories/login_repository.dart';
import 'features/auth/data/repositories/register_repository.dart';
import 'features/auth/data/repositories/reset_password_repository.dart';
import 'features/auth/presentation/bloc/location_provider.dart';
import 'features/auth/presentation/bloc/login_provider.dart';
import 'features/auth/presentation/bloc/register_provider.dart';
import 'features/auth/presentation/bloc/reset_password_provider.dart';
import 'features/auth/presentation/bloc/seller_register_provider.dart';
import 'features/auth/presentation/pages/header_provider.dart';
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
        ChangeNotifierProvider(create: (_) => HeaderProvider()..loadUser()),
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
            RegisterRepository(RegisterRemoteDatasource(DioClient())),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => VerifyOtpProvider(
            VerifyOtpRepository(VerifyRemoteOtpDatasource(DioClient())),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(
            LoginRepository(LoginRemoteDatasource(DioClient())),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => VerifyForgotPasswordOtpProvider(
            VerifyForgotPasswordOtpRepository(
              VerifyForgotPasswordOtpDatasource(DioClient()),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ResetPasswordProvider(
            ResetPasswordRepository(ResetPasswordRemoteDatasource(DioClient())),
          ),
        ),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => SellerRegisterProvider()),
        ChangeNotifierProvider(
          create: (_) => ProductDetailProvider(
            ProductDetailRepository(ProductDetailRemoteDatasource(DioClient())),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AddToCartProvider(
            AddToCartRepository(AddToCartRemoteDatasource(DioClient())),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => CheckoutProvider(
            CheckoutRepository(CheckoutRemoteDatasource(DioClient())),
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
