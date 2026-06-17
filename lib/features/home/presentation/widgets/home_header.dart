import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marshmallow/features/home/presentation/pages/wishlist_page.dart';

import '../../../../core/theme/app_colors.dart';
import '../bloc/product_provider.dart';
import '../pages/cart_page.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback onMenuTap;

  const HomeHeader({super.key, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<ProductProvider>();

    final cartCount = cartProvider.cartItems.fold(
      0,
      (sum, item) => sum + item.quantity,
    );

    final wishlistCount = cartProvider.wishlistCount;

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
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const WishlistPage()),
                );
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.favorite, color: AppColors.white, size: 30),

                  if (wishlistCount > 0)
                    Positioned(
                      right: -8,
                      top: -8,
                      child: Container(
                        padding: const EdgeInsets.all(4),

                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          wishlistCount > 99 ? "99+" : wishlistCount.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(width: 18),
           Row(
             children: [
               GestureDetector(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage()));
                 },
                child:  Stack(
                   clipBehavior: Clip.none,
                   children: [
                     const Icon(
                       Icons.shopping_cart,
                       color: AppColors.white,
                       size: 30,
                     ),
                     if (cartCount > 0)
                       Positioned(
                         right: -8,
                         top: -8,
                         child: Container(
                           padding: const EdgeInsets.all(4),
                           decoration: const BoxDecoration(
                             color: Colors.red,
                             shape: BoxShape.circle,
                           ),
                           constraints: const BoxConstraints(
                             minWidth: 18,
                             minHeight: 18,
                           ),
                           child: Text(
                             cartCount > 99 ? "99+" : cartCount.toString(),
                             textAlign: TextAlign.center,
                             style: const TextStyle(
                               color: Colors.white,
                               fontSize: 10,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                         ),
                       ),
                   ],
                 ),
               )
             ],
           ),

            const SizedBox(width: 18),

            GestureDetector(
              onTap: onMenuTap,
              child: const Icon(Icons.menu, color: AppColors.white, size: 30),
            ),
          ],
        ),
      ],
    );
  }
}
