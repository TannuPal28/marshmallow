import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marshmallow/core/theme/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(6)
      ),
      child: Row(
        children: [
          const Expanded(child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search for products, brand, more",
            ),
          )),
          Icon(Icons.search,
          color: AppColors.primary,)
        ],
      ),
    );
  }
}
