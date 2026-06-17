import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marshmallow/core/utils/auth_manager.dart';

import '../../features/auth/presentation/pages/login_page.dart';

class Utils {
  static final ImagePicker _picker = ImagePicker();
  // Gallery
  static Future<XFile?> pickImage(BuildContext context) async {
    return await showModalBottomSheet<XFile?>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () async {
                  final XFile? file = await _picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 80,
                  );

                  Navigator.pop(context, file);
                },
              ),

              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Gallery"),
                onTap: () async {
                  final XFile? file = await _picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 80,
                  );

                  Navigator.pop(context, file);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static void showMessage(
      BuildContext context,
      String message,
      ) {

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(
        content: Text(message),
      ),
    );
  }
  // Email Regex
  static bool isValidEmail(String email) {
    return RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(email);
  }

  // Mobile Regex
  static bool isValidMobile(String mobile) {
    return RegExp(r'^[0-9]{10}$').hasMatch(mobile);
  }

  // Password Regex
  static bool isValidPassword(String password) {
    return RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    ).hasMatch(password);
  }

  // PAN Regex
  static bool isValidPan(String pan) {
    return RegExp(
      r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$',
    ).hasMatch(pan);
  }

  // GST Regex
  static bool isValidGst(String gst) {
    return RegExp(
      r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$',
    ).hasMatch(gst);
  }

  // IFSC Regex
  static bool isValidIfsc(String ifsc) {
    return RegExp(
      r'^[A-Z]{4}0[A-Z0-9]{6}$',
    ).hasMatch(ifsc);
  }

  // Pincode Regex
  static bool isValidPincode(String pincode) {
    return RegExp(r'^[0-9]{6}$').hasMatch(pincode);
  }

  // Empty Check
  static bool isNotEmpty(String value) {
    return value.trim().isNotEmpty;
  }

  static Future<bool> checkLogin(
      BuildContext context,
      ) async {

    final token = await AuthManager.getToken();

    final isLoggedIn = token != null && token.isNotEmpty;

    if (!isLoggedIn) {

      Utils.showMessage(
        context,
        "Please login first",
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
      );
    }

    return isLoggedIn;
  }


}