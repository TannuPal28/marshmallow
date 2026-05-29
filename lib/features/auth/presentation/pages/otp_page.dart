import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:marshmallow/features/auth/presentation/bloc/login_provider.dart';
import 'package:marshmallow/features/auth/presentation/widgets/reset_password_dialog.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/auth_manager.dart';
import '../../../../core/utils/utils.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../bloc/register_provider.dart';
import '../bloc/verify_forgot_password_otp_provider.dart';
import '../bloc/verify_otp_provider.dart';
import '../widgets/otp_info_widget.dart';
import '../widgets/otp_textfield_widget.dart';
import '../widgets/otp_title_widget.dart';
import '../widgets/verify_otp_button_widget.dart';

class OtpPage extends StatefulWidget {
  final String mobile;
  final String email;

  final bool showMobileOtp;
  final bool showEmailOtp;
  final bool fromLogin;
  final bool isForgotPassword;

  const OtpPage({
    super.key,
    required this.mobile,
    required this.email,
    required this.showMobileOtp,
    required this.showEmailOtp,
    required this.fromLogin,
    required this.isForgotPassword,
  });

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController mobileOtpController = TextEditingController();

  final TextEditingController emailOtpController = TextEditingController();
  int secondsRemaining = 60;

  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();

    mobileOtpController.dispose();

    emailOtpController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  void startTimer() {
    secondsRemaining = 60;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          secondsRemaining--;
        });
      }
    });
  }

  Future<void> verifyOtp() async {
    if (widget.showMobileOtp) {
      if (mobileOtpController.text
          .trim()
          .isEmpty) {
        Utils.showMessage(context, "Enter mobile otp");

        return;
      }

      if (mobileOtpController.text
          .trim()
          .length != 4) {
        Utils.showMessage(context, "Enter valid mobile otp");

        return;
      }
    }

    if (widget.showEmailOtp) {
      if (emailOtpController.text
          .trim()
          .isEmpty) {
        Utils.showMessage(context, "Enter email otp");

        return;
      }

      if (emailOtpController.text
          .trim()
          .length != 4) {
        Utils.showMessage(context, "Enter valid email otp");

        return;
      }
    }

    /// FORGOT PASSWORD FLOW
    if (widget.isForgotPassword) {
      final forgotProvider =
      Provider.of<VerifyForgotPasswordOtpProvider>(
        context,
        listen: false,
      );

      final response =
      await forgotProvider.verifyForgotPasswordOtp(

        type: widget.showEmailOtp
            ? "email"
            : "mobile",

        countryCode: "91",

        otp: widget.showEmailOtp
            ? int.parse(
          emailOtpController.text.trim(),
        )
            : int.parse(
          mobileOtpController.text.trim(),
        ),

        email: widget.showEmailOtp
            ? widget.email
            : null,

        mobile: widget.showMobileOtp
            ? widget.mobile
            : null,
      );

      if (response != null &&
          response["success"] == true) {
        Utils.showMessage(
          context,
          response["message"],
        );

        //Reset password screen
        showDialog(
          context: context,
          builder: (_) => ResetPasswordDialog(

            isEmailSelected: widget.showEmailOtp,

            value: widget.showEmailOtp
                ? widget.email
                : widget.mobile,

            onBack: () {
              Navigator.pop(context);
            },
          ),
        );
      }
      else {
        Utils.showMessage(
          context,
          response["message"],
        );
      }

      return;
    }

    /// NORMAL LOGIN/SIGNUP OTP
    final provider = Provider.of<VerifyOtpProvider>(context, listen: false);

    final result = await provider.verifyOTP(
      fromLogin: widget.fromLogin,
      otpMobile: widget.showMobileOtp
          ? int.parse(mobileOtpController.text.trim())
          : null,

      otpEmail: widget.showEmailOtp
          ? int.parse(emailOtpController.text.trim())
          : null,

      mobile: widget.mobile,
      email: widget.email,
    );

    if (result != null && result.success == true) {
      await AuthManager.saveToken(result.results?.token ?? "");
      await AuthManager.saveUserData(
        name: result.results?.fullName ?? "",
        email: result.results?.email ?? "",
      );
      debugPrint(result.results?.token);
      debugPrint(result.results?.fullName);
      debugPrint(result.results?.email);

      Utils.showMessage(context, result.message!);

      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else {
      Utils.showMessage(context, provider.errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VerifyOtpProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black54,

      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),

          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(30),
          ),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                /// TITLE
                const OtpTitleWidget(),

                const SizedBox(height: 30),

                /// INFO
                OtpInfoWidget(mobile: widget.mobile, email: widget.email),

                const SizedBox(height: 30),

                const Text(
                  "Enter the 4-digit OTPs sent to your mobile number and email",

                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),

                const SizedBox(height: 30),

                if (widget.showMobileOtp)
                  OtpTextfieldWidget(
                    title: "Mobile OTP",

                    icon: Icons.call,

                    controller: mobileOtpController,
                  ),

                if (widget.showMobileOtp) const SizedBox(height: 30),

                if (widget.showEmailOtp)
                  OtpTextfieldWidget(
                    title: "Email OTP",

                    icon: Icons.email,

                    controller: emailOtpController,
                  ),
                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text(
                      secondsRemaining == 0
                          ? "Didn't receive OTP?"
                          : "Resend OTP in ",

                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),

                    if (secondsRemaining != 0)
                      Text(
                        "$secondsRemaining s",

                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    if (secondsRemaining == 0)
                      GestureDetector(
                        onTap: () async {
                          startTimer();


                          await resendOtp();
                          Utils.showMessage(context, "OTP Resent");

                          /// RESEND OTP API
                        },

                        child: const Text(
                          " Resend",

                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),

                /// BUTTON
                VerifyOtpButtonWidget(
                  isLoading: provider.isLoading,

                  onTap: provider.isLoading ? () {} : verifyOtp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> resendOtp() async {
    if (widget.fromLogin) {
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);

      final response = await loginProvider.login(
        type: widget.showEmailOtp ? "email" : "mobile",

        countryCode: "91",

        mobile: widget.showMobileOtp ? widget.mobile : null,

        email: widget.showEmailOtp ? widget.email : null,
      );

      if (response != null && response.success) {
        Utils.showMessage(
          context,
          "OTP resent successfully",
        );
      }
      else {
        Utils.showMessage(
          context,
          loginProvider.errorMessage,
        );
      }
    }
    else {
      final registerProvider =
      Provider.of<RegisterProvider>(
        context,
        listen: false,
      );

      final response =
      await registerProvider.register(
        fullName: "",
        email: widget.email,
        mobile: widget.mobile,
        password: "",
        countryCode: "91",
      );

      if (response != null &&
          response.success) {
        Utils.showMessage(
          context,
          "OTP resent successfully",
        );
      } else {
        Utils.showMessage(
          context,
          registerProvider.errorMessage,
        );
      }
    }
  }
}
