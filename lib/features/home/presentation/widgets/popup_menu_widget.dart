import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopupMenuWidget extends StatelessWidget {
  final bool isLoggedIn;

  final String userName;
  final String userEmail;
  final VoidCallback onLoginTap;
  final VoidCallback onSignupTap;
  final VoidCallback onSellerTap;
  final VoidCallback? onLogoutTap;

  const PopupMenuWidget({
    super.key,
    required this.isLoggedIn,
    required this.userName,
    required this.userEmail,
    required this.onLoginTap,
    required this.onSignupTap,
    required this.onSellerTap,
    required this.onLogoutTap,
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
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LOGIN USER MENU
          if (isLoggedIn) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xfff3f4f6),

                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi, $userName",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    userEmail,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),

            _buildMenuItem(title: "My Profile", onTap: () {}),

            _buildMenuItem(title: "My Orders", onTap: () {}),

            _buildMenuItem(
              title: "Logout",
              textColor: Colors.red,
              onTap: onLogoutTap,
            ),
          ]
          /// GUEST MENU
          else ...[
            _buildMenuItem(title: "Login", onTap: onLoginTap),

            _buildMenuItem(title: "Signup", onTap: onSignupTap),

            _buildMenuItem(title: "Become Seller", onTap: onSellerTap),
          ],
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required String title,
    Color textColor = Colors.black,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,

      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),

        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xffe5e7eb))),
        ),

        child: Text(title, style: TextStyle(fontSize: 18, color: textColor)),
      ),
    );
  }
}
