import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifyOtpButtonWidget extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;
  const VerifyOtpButtonWidget({super.key,
    required this.isLoading,
    required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:   const Color(0xffd97b95),
          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(
              15,
            ),
          ),
        ),
          onPressed: onTap, child: isLoading ? const CircularProgressIndicator(
        color:  Colors.white,
      ): const Text(
        "Verify OTP",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight:
          FontWeight.bold,
        ),
      )),
    );
  }
}
