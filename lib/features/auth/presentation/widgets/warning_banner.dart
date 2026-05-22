import 'package:flutter/cupertino.dart';

class WarningBanner extends StatelessWidget {
  final String message;

  const WarningBanner({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE4E6),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFFECDD3)),
      ),
      child: Text(
        message,
        style: const TextStyle(color: Color(0xFF9F1239), fontSize: 12),
      ),
    );
  }
}
