import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class CheckoutStepsWidget extends StatelessWidget {
  final int currentStep;

  const CheckoutStepsWidget({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
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
            "Checkout",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 25),

          Row(
            children: [
              Expanded(
                child: _stepItem(
                  title: "1. Delivery",
                  isCompleted: currentStep > 1,
                  isActive: currentStep == 1,
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: _stepItem(
                  title: "2. Review Order",
                  isCompleted: currentStep > 2,
                  isActive: currentStep == 2,
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: _stepItem(
                  title: "3. Payment",
                  isCompleted: false,
                  isActive: currentStep == 3,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              minHeight: 8,
              value: currentStep / 3,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation(
                AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepItem({
    required String title,
    required bool isCompleted,
    required bool isActive,
  }) {
    return Container(
      height: 55,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive || isCompleted
            ? AppColors.primary
            : Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: isActive || isCompleted
              ? AppColors.primary
              : Colors.grey.shade300,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isCompleted)
            const Icon(
              Icons.check,
              size: 16,
              color: Colors.white,
            ),

          if (isCompleted)
            const SizedBox(width: 4),

          Flexible(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isActive || isCompleted
                    ? Colors.white
                    : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}