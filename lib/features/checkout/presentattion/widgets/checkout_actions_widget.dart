import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marshmallow/core/theme/app_colors.dart';

class CheckoutActionsWidget extends StatelessWidget {
  const CheckoutActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () {},
              child: const Text("← Back to Cart",
                style: TextStyle(color: AppColors.black),),
            ),
          ),
          const SizedBox(height:5),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () {},
              child: const Text("Review Order",
              style: TextStyle(color: AppColors.white),),
            ),
          ),
        ],
      ),
    );
  }
}
