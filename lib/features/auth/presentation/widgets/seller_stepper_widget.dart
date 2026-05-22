import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class SellerStepperWidget extends StatelessWidget {
  final int currentStep;

  const SellerStepperWidget({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> steps = [
      {"number": "1", "title": "BASIC\nINFO"},
      {"number": "2", "title": "ADDRESS"},
      {"number": "3", "title": "TAX INFO"},
      {"number": "4", "title": "BANK"},
      {"number": "5", "title": "KYC"},
    ];

    return Container(
      width: double.infinity,
      color: const Color(0xfffdf2f4),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 24,
      ),

      child: Row(
        children: List.generate(steps.length, (index) {
          bool active = currentStep == index;

          final step = steps[index];

          return Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: active ? 64 : 50,
                  height: active ? 64 : 50,

                  decoration: BoxDecoration(
                    color: active
                        ? Colors.white
                        : Colors.transparent,

                    borderRadius: BorderRadius.circular(18),

                    boxShadow: active
                        ? [
                      const BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                      )
                    ]
                        : [],
                  ),

                  child: Center(
                    child: Container(
                      width: 36,
                      height: 36,

                      decoration: BoxDecoration(
                        color: active
                            ? AppColors.primary
                            : const Color(0xffe5e7eb),

                        shape: BoxShape.circle,
                      ),

                      child: Center(
                        child: Text(
                          step["number"],
                          style: TextStyle(
                            color: active
                                ? Colors.white
                                : const Color(0xff6b7280),

                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  step["title"],
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,

                    color: active
                        ? AppColors.primary
                        : const Color(0xff64748b),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}