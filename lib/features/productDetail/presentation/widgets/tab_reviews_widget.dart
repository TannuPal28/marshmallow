import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabReviewsWidget extends StatelessWidget {
  const TabReviewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Customer Reviews',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                '0.0',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Row(
                children: List.generate(
                  5,
                  (index) => const Icon(
                    Icons.star_border,
                    color: Colors.orange,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                '0 Ratings',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const Divider(height: 32),
          const Text(
            'No reviews yet',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Row(
            children: List.generate(
              5,
              (index) =>
                  const Icon(Icons.star_border, color: Colors.grey, size: 16),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'No Reviews',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
          ),
          const SizedBox(height: 4),
          const Text(
            'Be the first to review this product!',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
