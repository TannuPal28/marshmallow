import 'package:flutter/material.dart';

class TabDescriptionWidget extends StatelessWidget {
  final String title;
  final String description;
  final List<String> keyFeatures;

  const TabDescriptionWidget({
    super.key,
    required this.title,
    required this.description,
    required this.keyFeatures,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // डायनामिक टाइटल (जैसे: Product Description या Specifications)
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // डायनामिक डिस्क्रिप्शन text
          Text(
            description.isNotEmpty ? description : 'No description available.',
            style: TextStyle(color: Colors.grey[800], fontSize: 13, height: 1.5),
          ),

          // अगर keyFeatures लिस्ट खाली नहीं है, तभी यह सेक्शन दिखेगा
          if (keyFeatures.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Text(
              'Key Features',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // API से आने वाले सभी फीचर्स को लूप करके दिखाना
            Column(
              children: keyFeatures.map((feature) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      const Icon(Icons.check, color: Colors.green, size: 16),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          feature,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}