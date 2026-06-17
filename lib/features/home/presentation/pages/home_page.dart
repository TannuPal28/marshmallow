import 'package:flutter/material.dart';
import 'package:marshmallow/core/utils/auth_manager.dart';
import 'package:marshmallow/core/widgets/custom_search_bar.dart';
import 'package:marshmallow/features/auth/presentation/pages/login_page.dart';
import 'package:marshmallow/features/auth/presentation/pages/register_page.dart';
import 'package:marshmallow/features/auth/presentation/pages/seller_register_page.dart';
import 'package:marshmallow/features/home/presentation/bloc/category_provider.dart';
import 'package:marshmallow/features/home/presentation/bloc/product_provider.dart';
import 'package:marshmallow/features/home/presentation/widgets/banner_slider_widget.dart';
import 'package:marshmallow/features/home/presentation/widgets/category_widget.dart';
import 'package:marshmallow/features/home/presentation/widgets/home_header.dart';
import 'package:marshmallow/features/home/presentation/widgets/popup_menu_widget.dart';
import 'package:marshmallow/features/home/presentation/widgets/trending_products_widget.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../bloc/banner_provider.dart';
import '../widgets/deal_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showMenu = false;
  bool isLoggedIn = false;
  String userName = "";
  String userEmail = "";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await checkLogin();

      final productProvider = context.read<ProductProvider>();

      if (isLoggedIn) {
        await productProvider.loadCartIfNeeded();
        await productProvider.fetchWishlist();
      }
    });
  }

  Future<void> checkLogin() async {

    final loggedIn =
    await AuthManager.isLoggedIn();

    debugPrint("LOGIN STATUS => $loggedIn");

    if (loggedIn) {

      userName =
      await AuthManager.getUserName();

      userEmail =
      await AuthManager.getUserEmail();

      debugPrint("USER NAME => $userName");

      debugPrint("USER EMAIL => $userEmail");
    }

    setState(() {

      isLoggedIn = loggedIn;
    });
  }

  Future<void> logout() async {
    await AuthManager.logout();
    setState(() {
      isLoggedIn = false;
      showMenu = false;
      userName = "";
      userEmail = "";

    });
  }

  @override
  Widget build(BuildContext context) {
    final bannerProvider = Provider.of<BannerProvider>(context);

    final categoryProvider = Provider.of<CategoryProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    /// SINGLE LOADER
    final isLoading =
        bannerProvider.isLoading ||
        categoryProvider.isLoading ||
        productProvider.isLoading;
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      color: AppColors.primary,
                      padding: const EdgeInsets.all(20),

                      child: Column(
                        children: [
                          HomeHeader(
                            onMenuTap: () {
                              setState(() {
                                showMenu = !showMenu;
                              });
                            },
                          ),
                          const SizedBox(height: 25),
                          const CustomSearchBar(),
                          if (showMenu)
                            PopupMenuWidget(
                              isLoggedIn: isLoggedIn,
                              userName: userName,
                              userEmail: userEmail,
                              onLoginTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginPage(),
                                  ),
                                );
                              },
                              onSignupTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const RegisterPage(),
                                  ),
                                );
                              },
                              onSellerTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const SellerRegisterPage(),
                                  ),
                                );
                              },
                              onLogoutTap: () async {
                                await logout();
                              },
                            ),
                        ],
                      ),
                    ),

                    const BannerSliderWidget(),
                    const SizedBox(height: 50),
                    const Text(
                      "Shop By Category",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 140,
                      child: Consumer<CategoryProvider>(
                        builder: (context, provider, child) {
                          if (provider.isLoading) {
                            return const Padding(
                              padding: EdgeInsets.all(20),
                              child: CircularProgressIndicator(),
                            );
                          }
                          return SizedBox(
                            height: 140,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              itemCount: provider.categories.length,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(width: 16),

                              itemBuilder: (context, index) {
                                final category = provider.categories[index];

                                return CategoryWidget(
                                  image: category.image,
                                  title: category.name,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    // const SizedBox(height: 10),
                    const Text(
                      "Best Deals",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 0.8,
                        children: const [
                          DealCardWidget(
                            image: "assets/images/mobile.jpeg",
                            title: "Mobile Mania",
                            subtitle: "Up to 70% Off",
                          ),

                          DealCardWidget(
                            image: "assets/images/electronics.jpg",
                            title: "Electronics Sale",
                            subtitle: "Min 50% Off",
                          ),

                          DealCardWidget(
                            image: "assets/images/fashion.jpeg",
                            title: "Fashion Deals",
                            subtitle: "Flat 60% Off",
                          ),
                          DealCardWidget(
                            image: "assets/images/kitchen.jpg",
                            title: "Home Essentials",
                            subtitle: "Starting ₹99",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    TrendingProductsWidget(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }
}
