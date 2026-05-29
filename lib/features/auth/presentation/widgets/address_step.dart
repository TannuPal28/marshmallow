import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marshmallow/features/auth/presentation/bloc/location_provider.dart';
import 'package:marshmallow/features/auth/presentation/widgets/build_label_widget.dart';
import 'package:marshmallow/features/auth/presentation/widgets/custom_auth_textfield.dart';
import 'package:provider/provider.dart';

import '../bloc/seller_register_provider.dart';

class AddressStep extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const AddressStep({super.key, required this.onNext, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocationProvider>(context);
    final sellerProvider = Provider.of<SellerRegisterProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Business Address",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xffa50034),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Enter your business address details",
            style: TextStyle(fontSize: 16, color: Color(0xff6b7280)),
          ),

          const SizedBox(height: 36),
          BuildLabelWidget(title: "Address Line 1 *"),
          const SizedBox(height: 14),
          CustomAuthTextfield(
            controller: sellerProvider.address1Controller,
            hintText: "Flat/House/Floor No.,Building Name",
            prefixIcon: Icons.location_on,
          ),
          const SizedBox(height: 34),
          BuildLabelWidget(title: "Address Line 2 *"),
          const SizedBox(height: 14),
          CustomAuthTextfield(
            controller: sellerProvider.address2Controller,
            hintText: "Street,Locality,Area",
            prefixIcon: Icons.location_on,
          ),
          const SizedBox(height: 34),
          BuildLabelWidget(title: "Landmark"),
          const SizedBox(height: 14),
          CustomAuthTextfield(
            controller: sellerProvider.landmarkController,
            hintText: "Nearby landmark",
            prefixIcon: Icons.location_on,
          ),
          const SizedBox(height: 34),
          BuildLabelWidget(title: "City *"),
          const SizedBox(height: 14),
          CustomAuthTextfield(
            controller:sellerProvider.cityController,
            hintText: "Enter City",
            prefixIcon: Icons.location_on,
          ),
          const SizedBox(height: 34),
          BuildLabelWidget(title: "State *"),
          const SizedBox(height: 14),
          CustomAuthTextfield(
            controller: sellerProvider.stateController,
            hintText: "Enter State",
            prefixIcon: Icons.location_on,
          ),
          const SizedBox(height: 34),
          BuildLabelWidget(title: "Pincode *"),
          const SizedBox(height: 14),
          CustomAuthTextfield(
            controller: sellerProvider.pincodeController,
            hintText: "Enter 6-digit pincode",
            prefixIcon: Icons.location_on,
          ),
          const SizedBox(height: 12),
          const Text(
            "Entering pincode will auto-fetch coordinates",
            style: TextStyle(color: Color(0xff6b7280), fontSize: 14),
          ),
          const SizedBox(height: 34),
          BuildLabelWidget(title: "Country"),
          const SizedBox(height: 14),
          CustomAuthTextfield(
            controller: sellerProvider.countryController,
            hintText: "India",
            prefixIcon: Icons.location_on,
          ),
          const SizedBox(height: 34),
          BuildLabelWidget(title: "Phone *"),
          const SizedBox(height: 14),
          CustomAuthTextfield(
            controller: sellerProvider.addressPhoneController,
            hintText: "Address phone number",
            prefixIcon: Icons.call,
          ),
          const SizedBox(height: 34),
          BuildLabelWidget(title: "Email"),
          const SizedBox(height: 14),
          CustomAuthTextfield(
            controller: sellerProvider.addressEmailController,
            hintText: "Address email",
            prefixIcon: Icons.email,
          ),

          const SizedBox(height: 34),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xfff0f7ff),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xffd0e2ff)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.red[700], size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      "Location Coordinates",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1d4ed8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: provider.isLoading
                        ? null
                        : provider.getCurrentLocation,
                    icon: const Icon(Icons.pin_drop, color: Colors.white),
                    label: provider.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            "Use Current Location",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffa50034),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Automatically detect your current location",
                  style: TextStyle(color: Color(0xff6b7280), fontSize: 13),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: provider.isLoading
                        ? null
                        : provider.getCoordinatesFromAddress,
                    icon: const Icon(Icons.location_on, color: Colors.white),
                    label: const Text(
                      "Get Coordinates from Address",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff749bc2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Get coordinates based on address details",
                  style: TextStyle(color: Color(0xff6b7280), fontSize: 13),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Latitude",
                  style: TextStyle(fontSize: 14, color: Color(0xff374151)),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: provider.latitudeController,
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: "Latitude will auto-fill",
                    hintStyle: const TextStyle(color: Color(0xff9ca3af)),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffd1d5db)),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Longitude",
                  style: TextStyle(fontSize: 14, color: Color(0xff374151)),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: provider.longitudeController,
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: "Longitude will auto-fill",
                    hintStyle: const TextStyle(color: Color(0xff9ca3af)),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffd1d5db)),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),

                //Error message
                if (provider.errorMessage.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xfffee2e2),

                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xfffca5a5)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning,
                          color: Colors.orange[700],
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            provider.errorMessage,
                            style: const TextStyle(
                              color: Color(0xffb91c1c),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 34),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton(
              onPressed: onBack,
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xfff3f4f6),
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Previous",
                style: TextStyle(
                  color: Color(0xff374151),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: (){
                if(sellerProvider.validateAddress(context)) {
                  onNext();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffa50034),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Next: Tax Information",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
