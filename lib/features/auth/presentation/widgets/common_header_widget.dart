import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_search_bar.dart';
import '../../../home/presentation/widgets/home_header.dart';
import '../../../home/presentation/widgets/popup_menu_widget.dart';
import '../pages/header_provider.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/seller_register_page.dart';

class CommonHeaderWidget extends StatelessWidget {
  const CommonHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final provider = context.watch<HeaderProvider>();

    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [

          HomeHeader(
            onMenuTap: provider.toggleMenu,
          ),

          const SizedBox(height: 25),

          const CustomSearchBar(),

          if (provider.showMenu)
            PopupMenuWidget(
              isLoggedIn: provider.isLoggedIn,
              userName: provider.userName,
              userEmail: provider.userEmail,

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

              onLogoutTap: provider.logout,
            ),
        ],
      ),
    );
  }
}