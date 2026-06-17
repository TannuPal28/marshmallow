import 'package:flutter/material.dart';
import 'package:marshmallow/features/checkout/data/models/address_model.dart';

class AddressCardWidget extends StatelessWidget {
  final AddressItem address;
  final bool isSelected;
  final Function(AddressItem) onSelect;

  const AddressCardWidget({
    super.key,
    required this.address,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(address),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.shade50 : Colors.grey.shade50,
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("🏠", style: TextStyle(fontSize: 30)),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          address.fullName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          address.addressType.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Text(
                    address.phone,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(height: 8),

                  Text("${address.line1}, ${address.line2}"),

                  const SizedBox(height: 4),

                  Text("${address.area}, ${address.city}"),
                  const SizedBox(height: 4),

                  Text("${address.state}, ${address.country}"),

                  const SizedBox(height: 4),

                  Text(address.postalCode),

                  if (address.defaultAddress)
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: const Text(
                        "DEFAULT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Radio<String>(
              value: address.id,
              groupValue: isSelected ? address.id : null,
              onChanged: (_) => onSelect(address),
            ),
          ],
        ),
      ),
    );
  }
}
