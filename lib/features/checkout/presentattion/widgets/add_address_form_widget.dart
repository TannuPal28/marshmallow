import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:marshmallow/features/checkout/data/models/add_address_request_model.dart';
import 'package:marshmallow/features/checkout/presentattion/bloc/checkout_provider.dart';

class AddAddressFormWidget extends StatefulWidget {
  const AddAddressFormWidget({super.key});

  @override
  State<AddAddressFormWidget> createState() => _AddAddressFormWidgetState();
}

class _AddAddressFormWidgetState extends State<AddAddressFormWidget> {
  bool isDefault = false;
  String addressType = "Home";
  final addressTypes = ["Home", "Office", "Other"];
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final line1Controller = TextEditingController();
  final line2Controller = TextEditingController();
  final landmarkController = TextEditingController();
  final areaController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();
  final floorController = TextEditingController();
  final howToReachController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    line1Controller.dispose();
    line2Controller.dispose();
    landmarkController.dispose();
    areaController.dispose();
    cityController.dispose();
    stateController.dispose();
    pincodeController.dispose();
    floorController.dispose();
    howToReachController.dispose();
    super.dispose();
  }

  InputDecoration fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    );
  }

  Widget titles(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Add New Address",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          titles("Full Name *"),
          TextField(
            controller: fullNameController,
            decoration: fieldDecoration("Enter full name"),
          ),
          const SizedBox(height: 25),
          titles("Phone Number *"),
          TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: fieldDecoration("Phone Number"),
          ),
          const SizedBox(height: 25),
          titles("Email Address"),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: fieldDecoration("Email"),
          ),
          const SizedBox(height: 25),

          titles("Address Line 1 *"),
          TextField(
            controller: line1Controller,
            decoration: fieldDecoration("House/Flat No, Building, Street"),
          ),

          const SizedBox(height: 25),

          titles("Address Line 2"),
          TextField(
            controller: line2Controller,
            decoration: fieldDecoration("Apartment, Suite, etc."),
          ),

          const SizedBox(height: 25),

          titles("Landmark"),
          TextField(
            controller: landmarkController,
            decoration: fieldDecoration("Nearby landmark"),
          ),

          const SizedBox(height: 25),

          titles("Area/Locality"),
          TextField(
            controller: areaController,
            decoration: fieldDecoration("Area or locality"),
          ),

          const SizedBox(height: 25),

          titles("City *"),
          TextField(
            controller: cityController,
            decoration: fieldDecoration("Enter city"),
          ),

          const SizedBox(height: 25),

          titles("State *"),
          TextField(
            controller: stateController,
            decoration: fieldDecoration("Enter state"),
          ),

          const SizedBox(height: 25),

          titles("Pincode *"),
          TextField(
            controller: pincodeController,
            keyboardType: TextInputType.number,
            decoration: fieldDecoration("Enter pincode"),
          ),

          const SizedBox(height: 25),

          titles("Address Type"),
          DropdownButtonFormField<String>(
            value: addressType,
            decoration: fieldDecoration(""),
            items: addressTypes
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) {
              setState(() {
                addressType = value!;
              });
            },
          ),
          const SizedBox(height: 25),
          titles("Floor/Apartment"),
          TextField(
            controller: floorController,
            decoration: fieldDecoration("Floor, Apartment No."),
          ),

          const SizedBox(height: 25),

          titles("How to Reach"),
          TextField(
            controller: howToReachController,
            decoration: fieldDecoration("Any directions"),
          ),

          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Set as default address",
                style: TextStyle(fontSize: 18),
              ),

              Switch(
                value: isDefault,
                onChanged: (value) {
                  setState(() {
                    isDefault = value;
                  });
                },
              ),
            ],
          ),

          const Divider(height: 35),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade300,
              ),
              onPressed: () {},
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),

          const SizedBox(height: 15),
          Consumer<CheckoutProvider>(
            builder: (context, provider, child) {
              return SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: provider.isAddingAddress
                      ? null
                      : () async {
                          if (fullNameController.text.trim().isEmpty ||
                              phoneController.text.trim().isEmpty ||
                              line1Controller.text.trim().isEmpty ||
                              cityController.text.trim().isEmpty ||
                              stateController.text.trim().isEmpty ||
                              pincodeController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Please fill all required fields",
                                ),
                              ),
                            );
                            return;
                          }

                          final request = AddAddressRequest(
                            fullName: fullNameController.text.trim(),
                            phone: phoneController.text.trim(),
                            email: emailController.text.trim(),
                            line1: line1Controller.text.trim(),
                            line2: line2Controller.text.trim(),
                            landmark: landmarkController.text.trim(),
                            area: areaController.text.trim(),
                            city: cityController.text.trim(),
                            state: stateController.text.trim(),
                            country: "India",
                            postalCode: pincodeController.text.trim(),
                            pinCode: pincodeController.text.trim(),
                            addressType: addressType,
                            floor: floorController.text.trim(),
                            howToReach: howToReachController.text.trim(),
                            defaultAddress: isDefault,
                          );

                          final success = await provider.addAddress(request);

                          if (!mounted) return;

                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Address Added Successfully"),
                              ),
                            );

                            fullNameController.clear();
                            phoneController.clear();
                            emailController.clear();
                            line1Controller.clear();
                            line2Controller.clear();
                            landmarkController.clear();
                            areaController.clear();
                            cityController.clear();
                            stateController.clear();
                            pincodeController.clear();
                            floorController.clear();
                            howToReachController.clear();
                          }
                        },
                  child: provider.isAddingAddress
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "Save Address",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
