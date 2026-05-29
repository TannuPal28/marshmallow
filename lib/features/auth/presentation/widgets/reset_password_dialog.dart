import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marshmallow/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/utils.dart';
import '../bloc/reset_password_provider.dart';
import '../pages/login_page.dart';

class ResetPasswordDialog extends StatefulWidget {
  final bool isEmailSelected;
  final String value;

  final VoidCallback onBack;

  const ResetPasswordDialog({
    super.key,
    required this.isEmailSelected,
    required this.value,
    required this.onBack,
  });

  @override
  State<ResetPasswordDialog> createState() => _ResetPasswordDialogState();
}

class _ResetPasswordDialogState extends State<ResetPasswordDialog> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ResetPasswordProvider>(context);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(26),
      ),

      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Reset Password",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),

                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: Column(
                  children: [
                    Icon(
                      widget.isEmailSelected ? Icons.email : Icons.call,
                      color: AppColors.primary,
                      size: 36,
                    ),
                    const SizedBox(height: 14),

                    Text(
                      widget.isEmailSelected
                          ? widget.value
                          : "+91 ${widget.value}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                "Create your new password",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),

              const SizedBox(height: 26),

              //success box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.green.shade100),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 30,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        "OTP verified successfully!",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "New Password",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF374151),
                  ),
                ),
              ),

              const SizedBox(height: 12),
              TextFormField(
                controller: passwordController,
                obscureText: obscurePassword,

                decoration: InputDecoration(
                  hintText: "Enter new password",

                  prefixIcon: Icon(Icons.lock, color: AppColors.primary),

                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },

                    icon: Icon(
                      obscurePassword
                          ? CupertinoIcons.eye_slash
                          : CupertinoIcons.eye,
                      color: AppColors.primary,
                    ),
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),

                    borderSide: const BorderSide(color: Colors.black12),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),

                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Confirm Password",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF374151),
                  ),
                ),
              ),

              const SizedBox(height: 12),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: obscureConfirmPassword,

                decoration: InputDecoration(
                  hintText: "Confirm new password",

                  prefixIcon: Icon(Icons.lock, color: AppColors.primary),

                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureConfirmPassword = !obscureConfirmPassword;
                      });
                    },

                    icon: Icon(
                      obscureConfirmPassword
                          ? CupertinoIcons.eye_slash
                          : CupertinoIcons.eye,
                      color: AppColors.primary,
                    ),
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),

                    borderSide: const BorderSide(color: Colors.black12),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),

                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
              ),

              const SizedBox(height: 34),
              Row(
                children: [
                  /// RESET BUTTON
                  Expanded(
                    child: SizedBox(
                      height: 58,

                      child: ElevatedButton(
                        onPressed: () async {
                          if (passwordController.text.trim().isEmpty) {
                            Utils.showMessage(context, "Enter new password");
                            return;
                          }

                          if (confirmPasswordController.text.trim().isEmpty) {
                            Utils.showMessage(
                              context,
                              "Enter confirm password",
                            );
                            return;
                          }

                          if (passwordController.text.trim() !=
                              confirmPasswordController.text.trim()) {
                            Utils.showMessage(
                              context,
                              "Password does not match",
                            );
                            return;
                          }

                          final provider = Provider.of<ResetPasswordProvider>(
                            context,
                            listen: false,
                          );

                          final response = await provider.resetPAssword(
                            newPassword: passwordController.text.trim(),
                            confirmPassword: confirmPasswordController.text
                                .trim(),
                            isEmailSelected: widget.isEmailSelected,
                            email: widget.isEmailSelected ? widget.value : null,

                            mobile: !widget.isEmailSelected
                                ? widget.value
                                : null,
                          );

                          if (response != null && response.success == true) {
                            Utils.showMessage(
                              context,
                              response.message ?? "Password reset successfully",
                            );



                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginPage(),
                              ),
                                  (route) => false,
                            );
                          } else {
                            Utils.showMessage(context, provider.errorMessage);
                          }
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),

                        child: provider.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Reset Password",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),
                  SizedBox(
                    height: 58,
                    width: 80,

                    child: OutlinedButton(
                      onPressed: widget.onBack,

                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),

                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back, color: Colors.black),

                          Text(
                            "Back",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
