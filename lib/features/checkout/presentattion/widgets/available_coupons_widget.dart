import 'package:flutter/material.dart';
import 'package:marshmallow/features/checkout/presentattion/bloc/checkout_provider.dart';
import 'package:provider/provider.dart';

class AvailableCouponsWidget extends StatelessWidget {
  const AvailableCouponsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutProvider>(
      builder: (context, provider, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              const Text(
                "Available Coupons",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 10),

              OutlinedButton.icon(
                onPressed: () {
                  provider.fetchCoupons();
                },
                icon: const Icon(Icons.refresh),
                label: const Text("Refresh", style: TextStyle(fontSize: 16)),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(160, 48),
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              if (provider.isLoadingCoupons)
                const Center(child: CircularProgressIndicator())
              else if (provider.couponResponse?.results.isEmpty ?? true)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 35),
                  child: const Center(
                    child: Text("No coupons available at the moment"),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final coupon = provider.couponResponse!.results[index];

                    return Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coupon.code,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(coupon.title),
                          const SizedBox(height: 5),
                          Text(coupon.description),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemCount: provider.couponResponse!.results.length,
                ),
            ],
          ),
        );
      },
    );
  }
}
