import 'package:flutter/material.dart';

class OtpInfoWidget extends StatelessWidget {
  final String mobile;
  final String email;

  const OtpInfoWidget({
    super.key,
    required this.mobile,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.blue.shade50,

        borderRadius: BorderRadius.circular(20),

        border: Border.all(
          color: Colors.blue.shade100,
        ),
      ),

      child: Column(
        children: [
          /// MOBILE
          if (mobile.isNotEmpty)
            Container(
              width: double.infinity,

              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 15,
              ),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(15),

                border: Border.all(
                  color: Colors.blue.shade100,
                ),
              ),

              child: Row(
                children: [
                  const Icon(
                    Icons.call,
                    color: Colors.pink,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      mobile,

                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          if (mobile.isNotEmpty && email.isNotEmpty)
            const SizedBox(height: 20),

          /// EMAIL
          if (email.isNotEmpty)
            Container(
              width: double.infinity,

              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 15,
              ),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(15),

                border: Border.all(
                  color: Colors.blue.shade100,
                ),
              ),

              child: Row(
                children: [
                  const Icon(
                    Icons.email,
                    color: Colors.pink,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      email,

                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}