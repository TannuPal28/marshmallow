import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_search_bar.dart';
import '../../../home/presentation/widgets/home_header.dart';
import '../../../home/presentation/widgets/popup_menu_widget.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/seller_register_page.dart';

class AuthHeaderWidget extends StatelessWidget {
  final bool showMenu;
  final VoidCallback onMenuTap;

  const AuthHeaderWidget({
    super.key,
    required this.showMenu,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          HomeHeader(
            onMenuTap: () {
              onMenuTap();
            },
          ),
          const SizedBox(height: 25),
          const CustomSearchBar(),

          if (showMenu)
            PopupMenuWidget(
              onLoginTap: () {
                onMenuTap();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },

              onSignupTap: () {
                onMenuTap();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterPage()),
                );
              },

              onSellerTap: () {
                onMenuTap();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SellerRegisterPage()),
                );
              },
            ),
        ],
      ),
    );
  }
}