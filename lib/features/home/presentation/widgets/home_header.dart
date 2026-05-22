import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback onMenuTap;

  const HomeHeader({super.key, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Shopping",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),

              TextSpan(
                text: "Cart",
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                )
              )
            ],
          ),
        ),
        Row(
          children: [
            const Icon(Icons.favorite,
            color: AppColors.white,
            size: 30,),

            const SizedBox(width: 18,),
            const Icon(Icons.shopping_cart,
            color: AppColors.white,
            size: 30,),

            const SizedBox(width: 18,),

            GestureDetector(
              onTap: onMenuTap,
              child: const Icon(
                Icons.menu,
                color: AppColors.white,
                size: 30,
              ),
            )
          ],
        )
      ],
    );
  }
}
