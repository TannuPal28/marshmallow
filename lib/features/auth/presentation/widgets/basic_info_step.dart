import 'package:flutter/material.dart';
import 'package:marshmallow/features/auth/presentation/widgets/build_label_widget.dart';
import '../../../../core/theme/app_colors.dart';
import 'custom_auth_textfield.dart';

class BasicInfoStep extends StatefulWidget {
  final VoidCallback onNext;
  const BasicInfoStep({super.key, required this.onNext,});

  @override
  State<BasicInfoStep> createState() => _BasicInfoStepState();
}

class _BasicInfoStepState extends State<BasicInfoStep> {
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Business Information",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xffa50034),
            ),
          ),
          const SizedBox(height: 10),

          const Text(
            "Tell us about your business",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff6b7280),
            ),
          ),

          const SizedBox(height: 36),
          BuildLabelWidget(title:"Business Name *"),
          const SizedBox(height: 14),

          CustomAuthTextfield(
            controller: TextEditingController(),
            hintText: "Enter your business name",
            prefixIcon: Icons.business,
          ),
          const SizedBox(height: 34),
          BuildLabelWidget(title:"Owner/Authorized Person Name *"),
          const SizedBox(height: 14),

          CustomAuthTextfield(
            controller: TextEditingController(),
            hintText: "Enter owner name",
            prefixIcon: Icons.person,
          ),

          const SizedBox(height: 34),
          BuildLabelWidget(title:"Business Type *"),
          const SizedBox(height: 14),
          Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffd1d5db)),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(Icons.business, color: AppColors.primary),

                const SizedBox(width: 16),

                const Expanded(
                  child: Text(
                    "Select Business Type",
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 34),

          BuildLabelWidget(title:"Legal Business Name (if different)"),

          const SizedBox(height: 14),


          CustomAuthTextfield(
            controller: TextEditingController(),
            hintText: "Enter legal business name",
            prefixIcon: Icons.business,
          ),

          const SizedBox(height: 34),

          BuildLabelWidget(title:"Business Email *"),
          const SizedBox(height: 14),


          CustomAuthTextfield(
            controller: TextEditingController(),
            hintText: "Enter business email",
            prefixIcon: Icons.email,
          ),

          const SizedBox(height: 34),

          BuildLabelWidget(title:"Business Mobile *"),

          const SizedBox(height: 14),

         CustomAuthTextfield(
           controller: TextEditingController(),
            hintText: "Enter 10-digit mobile number",
            prefixIcon: Icons.phone,
          ),
          const SizedBox(height: 34),

          BuildLabelWidget(title:"Alternate Email"),

          const SizedBox(height: 14),

          CustomAuthTextfield(
            controller: TextEditingController(),
            hintText: "Enter alternate email",
            prefixIcon: Icons.email,
          ),

          const SizedBox(height: 34),

          BuildLabelWidget(title:"Alternate Mobile"),

          const SizedBox(height: 14),

          CustomAuthTextfield(
            controller: TextEditingController(),
            hintText: "Enter alternate mobile",
            prefixIcon: Icons.phone,
          ),

          const SizedBox(height: 34),
          BuildLabelWidget(title:"Password *"),

          const SizedBox(height: 14),

          CustomAuthTextfield(
            controller: TextEditingController(),
            hintText: "Create password (min 8 characters)",
            prefixIcon: Icons.key,
            suffixText: passwordVisible ? "Hide" : "Show",
            obscureText: !passwordVisible,
            onSuffixTap: () {
              setState(() {
                passwordVisible = !passwordVisible;
              });
            },
          ),

          const SizedBox(height: 12),

          const Text(
            "Must contain at least 8 characters with uppercase, lowercase, and numbers",
            style: TextStyle(
              color: Color(0xff6b7280),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 34),

          BuildLabelWidget(title: "Confirm Password *", ),

          const SizedBox(height: 14),

          CustomAuthTextfield(
            controller: TextEditingController(),
            hintText: "Confirm your password",
            prefixIcon: Icons.key,
            suffixText: confirmPasswordVisible ? "Hide" : "Show",
            obscureText: !confirmPasswordVisible,
            onSuffixTap: () {
              setState(() {
                confirmPasswordVisible = !confirmPasswordVisible;
              });
            },
          ),

          const SizedBox(height: 50),

          SizedBox(
            width: double.infinity,
            height: 60,

            child: ElevatedButton(
              onPressed: () {
                widget.onNext();
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),

              child: const Text(
                "Next: Business Address",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
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

