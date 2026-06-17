import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:marshmallow/core/theme/app_colors.dart';
import 'package:marshmallow/features/checkout/presentattion/pages/review_order_page.dart';
import 'package:marshmallow/features/checkout/presentattion/widgets/add_address_form_widget.dart';
import 'package:marshmallow/features/checkout/presentattion/widgets/checkout_actions_widget.dart';
import 'package:marshmallow/features/checkout/presentattion/widgets/order_summary_widget.dart';
import 'package:marshmallow/features/checkout/presentattion/widgets/saved_addresses_widget.dart';

import '../../../auth/presentation/widgets/common_header_widget.dart';
import '../../../home/presentation/bloc/product_provider.dart';
import '../bloc/checkout_provider.dart';
import '../widgets/available_coupons_widget.dart';
import '../widgets/checkout_steps_widget.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}



class _CheckoutPageState extends State<CheckoutPage> {
  bool showAddAddress = false;

  int currentStep = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask((){
      context.read<CheckoutProvider>().fetchCoupons();
      context.read<ProductProvider>().loadCartIfNeeded(
        forceRefresh: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// HEADER
              const CommonHeaderWidget(),

              const SizedBox(height: 15),

              /// CHECKOUT STEPS
              const CheckoutStepsWidget(
                currentStep: 1,
              ),

              const SizedBox(height: 15),

              /// ADDRESS SECTION
              SavedAddressesWidget(
                onAddAddress: () {
                  setState(() {
                    showAddAddress = !showAddAddress;
                  });
                },
              ),

              if (showAddAddress) ...[
                const SizedBox(height: 15),
                const AddAddressFormWidget(),
              ],

              const SizedBox(height: 15),
              // CheckoutActionsWidget(),
              // const SizedBox(height: 15),

              /// ORDER SUMMARY
              const OrderSummaryWidget(),

              const SizedBox(height: 15),
              const AvailableCouponsWidget(),

              const SizedBox(height: 20),

              /// ACTION BUTTONS
              _buildBottomActions(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
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
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ReviewOrderPage(),
                  ),
                );
              },
              child: const Text(
                "Continue",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
