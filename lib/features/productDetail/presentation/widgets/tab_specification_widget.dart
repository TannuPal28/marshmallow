import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabSpecificationWidget extends StatelessWidget {
  const TabSpecificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Specifications',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildSpecHeader('General'),
          _buildSpecRow('Title', 'Safari Small Cabin Suitcase 55 cm 4 Wheels'),
          _buildSpecRow('Type', 'Variable Product'),
          _buildSpecRow('Category', '695de17417cfe023b9934390'),
          _buildSpecRow('Brand', '695cc345ae2922fe15d71c54'),
          _buildSpecRow('SKU', 'N/A'),

          _buildSpecHeader('Pricing'),
          _buildSpecRow('Price', '₹17,999.1'),
          _buildSpecRow('MRP', '₹19,999'),
          _buildSpecRow('Discount', '10%'),
          _buildSpecRow('GST', '12%'),
        ],
      ),
    );
  }

  Widget _buildSpecHeader(String sectionTitle) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(sectionTitle, style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14)),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildSpecRow(String field, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(field, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 2),
          Text(val, style: TextStyle(color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}
