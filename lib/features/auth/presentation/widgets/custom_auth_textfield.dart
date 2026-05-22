import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class CustomAuthTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final String? suffixText;
  final VoidCallback? onSuffixTap;


  const CustomAuthTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.suffixText,
    this.onSuffixTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffd1d5db)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 16, color: Color(0xff9ca3af)),
          prefixIcon: Icon(prefixIcon, color: AppColors.primary),

          suffixIcon: suffixIcon != null
              ? GestureDetector(
                  onTap: onSuffixTap,
                  child: Icon(suffixIcon, color: AppColors.primary),
                )
              : null,
        ),
      ),
    );
  }
}
