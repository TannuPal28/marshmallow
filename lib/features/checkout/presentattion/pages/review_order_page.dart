import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marshmallow/features/checkout/presentattion/widgets/checkout_steps_widget.dart';
import 'package:marshmallow/features/checkout/presentattion/widgets/delivery_address_card_widget.dart';
import 'package:marshmallow/features/checkout/presentattion/widgets/order_items_widget.dart';
import 'package:marshmallow/features/checkout/presentattion/widgets/order_summary_widget.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_search_bar.dart';
import '../../../auth/presentation/widgets/common_header_widget.dart';
import '../../../home/presentation/widgets/home_header.dart';
import '../../../home/presentation/widgets/popup_menu_widget.dart';
import '../widgets/available_coupons_widget.dart';

class ReviewOrderPage extends StatelessWidget {
  const ReviewOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            /// HEADER
           const CommonHeaderWidget(),
            const SizedBox(height: 15,),
            const CheckoutStepsWidget(currentStep: 2),
            const SizedBox(height: 15,),
            //Order review
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Order Review",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),),
                  const SizedBox(height: 25,),
                  const DeliveryAddressCardWidget(),
                  const SizedBox(height: 10,),
                  const OrderItemsWidget(),
                ],
              ),
            ),

            const SizedBox(height: 15,),
            const OrderSummaryWidget(),
            const SizedBox(height: 15,),
            /// ACTION BUTTONS
            const AvailableCouponsWidget(),

            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    // Payment Page
                  },
                  child: const Text(
                    "Continue To Payment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      )),
    );
  }
}
