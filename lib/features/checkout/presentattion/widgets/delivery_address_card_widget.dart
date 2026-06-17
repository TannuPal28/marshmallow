import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marshmallow/features/checkout/presentattion/bloc/checkout_provider.dart';

class DeliveryAddressCardWidget extends StatelessWidget {
  const   DeliveryAddressCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider= context.watch<CheckoutProvider>();
    final address = provider.selectedAddress;

    if (address == null) {
      return Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(
          child: Text("No address selected"),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Delivery Address",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 30),

          Text(
            address.fullName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            [
              address.line1,
              address.line2,
              address.landmark,
            ].where((e) => e.isNotEmpty).join(", "),
          ),

          const SizedBox(height: 4),

          Text(
            [
              address.area,
              address.city,
              address.state,
              address.postalCode,
            ].where((e) => e.isNotEmpty).join(", "),
          ),

          const SizedBox(height: 10),

          Text("📱 ${address.phone}"),

          const SizedBox(height: 6),

          if (address.email.isNotEmpty)
            Text("📧 ${address.email}"),

          // const SizedBox(height: 18),

        /*  ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Change Address"),
          ),*/
        ],
      ),
    );
  }
}
