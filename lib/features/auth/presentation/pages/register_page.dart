import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:marshmallow/features/auth/data/models/register_model.dart';
import 'package:marshmallow/features/auth/presentation/bloc/register_provider.dart';
import 'package:marshmallow/features/auth/presentation/widgets/auth_header_widget.dart';
import 'package:marshmallow/features/auth/presentation/widgets/common_header_widget.dart';
import 'package:marshmallow/features/auth/presentation/widgets/custom_auth_textfield.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import 'login_page.dart';
import 'otp_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  bool agreeTerms = false;
  bool updates = true;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController mobileController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void registerUser() async {
    if (firstNameController.text.trim().isEmpty) {
      showMessage("Enter first name");
      return;
    }
    if (lastNameController.text.trim().isEmpty) {
      showMessage("Enter last name");
      return;
    }

    if (emailController.text.trim().isEmpty) {
      showMessage("Enter email");
      return;
    }

    if (mobileController.text.trim().isEmpty) {
      showMessage("Enter mobile number");
      return;
    }

    if (mobileController.text.trim().length != 10) {
      showMessage("Enter valid mobile number");
      return;
    }

    if (passwordController.text.trim().isEmpty) {
      showMessage("Enter password");
      return;
    }

    if (passwordController.text.trim().length < 6) {
      showMessage("Password must be at least 6 characters");
      return;
    }

    if (confirmPasswordController.text.trim().isEmpty) {
      showMessage("Enter confirm password");
      return;
    }

    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      showMessage("Passwords do not match");
      return;
    }

    if (!agreeTerms) {
      showMessage("Please accept terms & conditions");
      return;
    }
    final provider = Provider.of<RegisterProvider>(context, listen: false);
    final result = await provider.register(
      fullName:
          "${firstNameController.text.trim()} ${lastNameController.text.trim()}",
      email: emailController.text.trim(),
      mobile: mobileController.text.trim(),
      password: passwordController.text.trim(),
      countryCode: "91",
    );

    if (result != null && result.success) {
      RegisterUser user = result.results;
      showMessage(result.message);

      debugPrint(user.fullName);
      debugPrint(user.email);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OtpPage(
            mobile: mobileController.text.trim(),
            email: emailController.text.trim(),
            showMobileOtp: true,
            showEmailOtp: true,
            fromLogin: false,
            isForgotPassword: false,
          ),
        ),
      );
    } else {
      showMessage(provider.errorMessage);
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegisterProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFEDF2F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CommonHeaderWidget(),
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        "Create Your Account",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1f2937),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    const Center(
                      child: Text(
                        "Join us and start shopping today",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff6b7280),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    const Text(
                      "First Name *",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff374151),
                      ),
                    ),
                    const SizedBox(height: 14),

                    CustomAuthTextfield(
                      controller: firstNameController,
                      hintText: "First name",
                      prefixIcon: Icons.person,
                    ),

                    const SizedBox(height: 28),
                    const Text(
                      "Last Name *",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff374151),
                      ),
                    ),
                    const SizedBox(height: 14),

                    CustomAuthTextfield(
                      controller: lastNameController,
                      hintText: "Last name",
                      prefixIcon: Icons.person,
                    ),
                    const SizedBox(height: 28),

                    const Text(
                      "Email Address *",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff374151),
                      ),
                    ),

                    const SizedBox(height: 14),
                    CustomAuthTextfield(
                      controller: emailController,
                      hintText: "Enter you email",
                      prefixIcon: Icons.email,
                    ),
                    const SizedBox(height: 28),

                    const Text(
                      "Phone number *",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff374151),
                      ),
                    ),
                    const SizedBox(height: 14),

                    CustomAuthTextfield(
                      controller: mobileController,
                      hintText: "Enter 10-digit mobile number",
                      prefixIcon: Icons.phone,
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "We'll send an OTP to this number for verification",
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Color(0xff6b7280),
                      ),
                    ),

                    const SizedBox(height: 34),

                    const Text(
                      "Password *",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff374151),
                      ),
                    ),

                    const SizedBox(height: 14),
                    CustomAuthTextfield(
                      controller: passwordController,
                      hintText: "Create a password (min 6 characters)",
                      prefixIcon: Icons.lock,
                      suffixIcon: passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      obscureText: !passwordVisible,
                      onSuffixTap: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Password must be at least 6 characters long",
                      style: TextStyle(fontSize: 14, color: Color(0xff6b7280)),
                    ),

                    const SizedBox(height: 34),

                    const Text(
                      "Confirm Password *",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff374151),
                      ),
                    ),

                    const SizedBox(height: 14),

                    CustomAuthTextfield(
                      controller: confirmPasswordController,
                      hintText: "Confirm your password",
                      prefixIcon: Icons.lock,
                      suffixIcon: confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      obscureText: !confirmPasswordVisible,
                      onSuffixTap: () {
                        setState(() {
                          confirmPasswordVisible = !confirmPasswordVisible;
                        });
                      },
                    ),

                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffe5e7eb)),
                        borderRadius: BorderRadius.circular(14),
                      ),

                      child: Row(
                        children: [
                          Checkbox(
                            value: agreeTerms,
                            activeColor: AppColors.primary,
                            onChanged: (value) {
                              setState(() {
                                agreeTerms = value!;
                              });
                            },
                          ),
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xff374151),
                                ),
                                children: [
                                  TextSpan(text: "I agree to the "),
                                  TextSpan(
                                    text: "Terms of Service",
                                    style: TextStyle(color: Color(0xffa50034)),
                                  ),
                                  TextSpan(text: " and "),
                                  TextSpan(
                                    text: "Privacy Policy",
                                    style: TextStyle(color: Color(0xffa50034)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    Row(
                      children: [
                        Checkbox(
                          value: updates,
                          activeColor: AppColors.primary,
                          onChanged: (value) {
                            setState(() {
                              updates = value!;
                            });
                          },
                        ),
                        const Expanded(
                          child: Text(
                            "Send me product updates and shopping recommendations",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff374151),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 34),
                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        onPressed: provider.isLoading ? null : registerUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: provider.isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                "Create Account",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 34),
                    const Divider(),
                    const SizedBox(height: 28),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xff6b7280),
                          ),
                          children: [
                            const TextSpan(text: "Already have an account? "),
                            TextSpan(
                              text: "Sign in",
                              style: const TextStyle(
                                color: Color(0xffa50034),
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
