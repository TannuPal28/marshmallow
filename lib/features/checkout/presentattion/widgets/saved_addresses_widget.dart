import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../bloc/checkout_provider.dart';
import 'address_card_widget.dart';

class SavedAddressesWidget extends StatefulWidget {
  final VoidCallback onAddAddress;

  const SavedAddressesWidget({super.key, required this.onAddAddress});

  @override
  State<SavedAddressesWidget> createState() => _SavedAddressesWidgetState();
}

class _SavedAddressesWidgetState extends State<SavedAddressesWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CheckoutProvider>().fetchAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutProvider>(
      builder: (context, provider, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              const Text(
                "Saved Addresses",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: widget.onAddAddress,
                  child: const Text("+ Add New Address"),
                ),
              ),

              const SizedBox(height: 15),

              if (provider.isLoading)
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(),
                ),

              if (!provider.isLoading &&
                  provider.addressResponse != null &&
                  provider.addressResponse!.results.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "No Address Available.\nPlease Add Address",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),

              if (!provider.isLoading &&
                  provider.addressResponse != null &&
                  provider.addressResponse!.results.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.addressResponse!.results.length,
                  itemBuilder: (context, index) {
                    final address = provider.addressResponse!.results[index];
                    return AddressCardWidget(
                      address: address,
                      isSelected: provider.selectedAddress?.id == address.id,
                      onSelect: (selectedAddress) {
                        provider.selectAddress(selectedAddress);
                      },
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
