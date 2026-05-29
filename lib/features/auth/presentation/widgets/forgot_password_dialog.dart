import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/utils.dart';
import '../../presentation/bloc/login_provider.dart';
import '../pages/otp_page.dart';

class ForgotPasswordDialog extends StatelessWidget {
  final bool isEmailSelected;
  final TextEditingController emailController;

  const ForgotPasswordDialog({
    super.key,
    required this.isEmailSelected,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// TOP
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    size: 28,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// INFO BOX
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 25,
              ),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.blue.shade100,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    isEmailSelected
                        ? Icons.email
                        : Icons.call,
                    color: Colors.pink,
                    size: 32,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    isEmailSelected
                        ? emailController.text.trim()
                        : "+91 ${emailController.text.trim()}",
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Text(
              isEmailSelected
                  ? "We'll send an OTP to your email to verify your identity"
                  : "We'll send an OTP to your mobile number to verify your identity",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            /// BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {

                  final response =
                  await provider.forgotPassword(
                    type: isEmailSelected
                        ? "email"
                        : "mobile",

                    countryCode: "91",

                    email: isEmailSelected
                        ? emailController.text.trim()
                        : null,

                    mobile: !isEmailSelected
                        ? emailController.text.trim()
                        : null,
                  );

                  if (response != null &&
                      response["success"] == true) {

                    Navigator.pop(context);

                    Utils.showMessage(
                      context,
                      response["message"],
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OtpPage(
                          mobile: !isEmailSelected
                              ? emailController.text.trim()
                              : "",

                          email: isEmailSelected
                              ? emailController.text.trim()
                              : "",

                          showMobileOtp:
                          !isEmailSelected,

                          showEmailOtp:
                          isEmailSelected,

                          fromLogin: true,
                          isForgotPassword: true,
                        ),
                      ),
                    );
                  }
                  else {

                    Utils.showMessage(
                      context,
                      provider.errorMessage,
                    );
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),

                child: provider.isLoading
                    ? const CircularProgressIndicator(
                  color: Colors.white,
                )
                    : const Text(
                  "Send OTP",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}