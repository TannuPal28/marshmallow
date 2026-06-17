import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marshmallow/core/utils/utils.dart';
import 'package:marshmallow/features/auth/presentation/bloc/login_provider.dart';
import 'package:marshmallow/features/auth/presentation/pages/register_page.dart';
import 'package:marshmallow/features/auth/presentation/widgets/forgot_password_dialog.dart';
import 'package:marshmallow/features/auth/presentation/widgets/google_buttons.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/auth_manager.dart';
import '../../../../core/widgets/custom_search_bar.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../home/presentation/widgets/home_header.dart';
import '../../../home/presentation/widgets/popup_menu_widget.dart';
import '../widgets/auth_header_widget.dart';
import '../widgets/login_tab_button.dart';
import '../widgets/warning_banner.dart';
import 'header_provider.dart';
import 'otp_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool obscurePassword = true;
  bool isEmailSelected = false;
  bool loginWithPassword = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    final headerProvider = context.watch<HeaderProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFFEDF2F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AuthHeaderWidget(
                showMenu: headerProvider.showMenu,

                onMenuTap: () {
                  headerProvider.toggleMenu();
                },

                isLoggedIn: headerProvider.isLoggedIn,

                userName: headerProvider.userName,

                userEmail: headerProvider.userEmail,

                onLogoutTap: () async {
                  await headerProvider.logout();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 24.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Sign in to your account to continue shopping',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        const SizedBox(height: 20),

                        // Google Button
                        const GoogleButtons(),
                        const SizedBox(height: 20),

                        Text(
                          isEmailSelected
                              ? 'or continue with email'
                              : 'or continue with mobile',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 16),

                        Row(
                          children: [
                            LoginTabButton(
                              text: 'Email',
                              icon: Icons.email,
                              isActive: isEmailSelected,
                              onTap: () => setState(() {
                                isEmailSelected = true;
                              }),
                            ),
                            const SizedBox(width: 10),
                            LoginTabButton(
                              text: 'Mobile',
                              icon: Icons.phone,
                              isActive: !isEmailSelected,
                              onTap: () =>
                                  setState(() => isEmailSelected = false),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Error Banner
                        const WarningBanner(
                          message:
                              'Please enter your email or mobile number first',
                        ),
                        const SizedBox(height: 16),

                        // Label (Email Address / Mobile Number)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            isEmailSelected ? 'Email Address' : 'Mobile Number',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF334155),
                              fontSize: 13,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),

                        TextFormField(
                          controller: emailController,
                          keyboardType: isEmailSelected
                              ? TextInputType.emailAddress
                              : TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: isEmailSelected
                                ? "Enter your email address"
                                : "Enter your 10-digits mobile number",
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                              fontSize: 13,
                            ),
                            prefixIcon: Icon(
                              isEmailSelected
                                  ? Icons.email_outlined
                                  : Icons.phone,
                              color: AppColors.primary,
                              size: 18,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        if (!loginWithPassword) ...[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              isEmailSelected
                                  ? "We'll send an OTP to this email"
                                  : "We'll send an OTP to this number",
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                        if (loginWithPassword) ...[
                          const SizedBox(height: 12),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF334155),
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: passwordController,
                            obscureText: obscurePassword,
                            decoration: InputDecoration(
                              hintText: "Enter you password",
                              hintStyle: const TextStyle(
                                color: Colors.black12,
                                fontSize: 13,
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: AppColors.primary,
                                size: 18,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () => setState(() {
                                  obscurePassword = !obscurePassword;
                                }),
                                icon: Icon(
                                  obscurePassword
                                      ? CupertinoIcons.eye_slash
                                      : CupertinoIcons.eye,
                                  color: AppColors.primary,
                                  size: 18,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(
                                  color: Colors.black12,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(
                                  color: Colors.black12,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                if(emailController.text.trim().isEmpty){
                                  Utils.showMessage(
                                    context,
                                    isEmailSelected
                                        ? "Enter email"
                                        : "Enter mobile number",
                                  );

                                  return;
                                }
                                showDialog(context: context, builder: (_) => ForgotPasswordDialog(isEmailSelected: isEmailSelected, emailController: emailController
                                ));

                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                              ),
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 16),

                        Row(
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Checkbox(
                                value: loginWithPassword,
                                activeColor: AppColors.primary,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onChanged: (val) {
                                  setState(() {
                                    loginWithPassword = val ?? false;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Login with Password',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: ElevatedButton(
                            onPressed: provider.isLoading
                            ? null
                            : loginUser,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: provider.isLoading
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,

                                    child: CircularProgressIndicator(
                                      color: Colors.white,

                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    loginWithPassword
                                        ? 'Sign in with Password'
                                        : (isEmailSelected
                                              ? 'Send OTP to Email'
                                              : 'Send OTP to Mobile'),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(color: Colors.black12),
                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const RegisterPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    if (emailController.text.trim().isEmpty) {
      Utils.showMessage(
        context,
        isEmailSelected ? "Enter email" : "Enter mobile number",
      );

      return;
    }
    if (loginWithPassword && passwordController.text.trim().isEmpty) {
      Utils.showMessage(context, "Enter password");

      return;
    }

    final provider = Provider.of<LoginProvider>(context, listen: false);

    final response = await provider.login(
      type: loginWithPassword
          ? "password"
          : (isEmailSelected ? "email" : "mobile"),

      countryCode: "91",

      mobile: !isEmailSelected && !loginWithPassword
          ? emailController.text.trim()
          : null,

      email: isEmailSelected && !loginWithPassword
          ? emailController.text.trim()
          : null,

      emailOrMobile: loginWithPassword ? emailController.text.trim() : null,

      password: loginWithPassword ? passwordController.text.trim() : null,
    );

    if (response != null && response.success) {
      Utils.showMessage(context, response.message);

      if (loginWithPassword) {
        debugPrint(response.results?.token);
        debugPrint(response.results?.fullName);
        debugPrint(response.results?.email);

        await AuthManager.saveToken(response.results?.token ?? "");
        await AuthManager.saveUserData(
          name: response.results?.fullName ?? "",
          email: response.results?.email ?? "",
        );

        await context.read<HeaderProvider>().loadUser();

        Navigator.pushReplacement(
          context,

          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      } else {
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

              showMobileOtp: !isEmailSelected,

              showEmailOtp: isEmailSelected,
              fromLogin: true,
              isForgotPassword: false,
            ),
          ),
        );
      }
    } else {
      Utils.showMessage(context, provider.errorMessage);
    }
  }
}
