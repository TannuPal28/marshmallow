import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoogleButtons extends StatelessWidget {
  const GoogleButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: (){},
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.black12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6)
          ),
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
          backgroundColor: const Color(0xFFF8FAFC)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/google.jpg",
              height: 16,
            ),
            const SizedBox(width: 10),
            const Text(
              'Sign in with Google',
              style: TextStyle(color: Color(0xFF334155), fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ],
        ));
  }
}
