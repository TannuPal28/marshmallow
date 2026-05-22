import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopupMenuWidget extends StatelessWidget {
  final VoidCallback onLoginTap;
  final VoidCallback onSignupTap;
  final VoidCallback onSellerTap;

  const PopupMenuWidget({
    super.key,
    required this.onLoginTap,
    required this.onSignupTap,
    required this.onSellerTap,
  });

  Widget menuItem({required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Text(title, style: const TextStyle(fontSize: 18)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4)
      ),

      child: Column(
        children: [
          menuItem(title: "Login", onTap: onLoginTap),
          menuItem(title: "Sign up", onTap: onSignupTap),
          menuItem(title: "Become a seller", onTap: onSellerTap),
        ],
      ),
    );
  }
}
