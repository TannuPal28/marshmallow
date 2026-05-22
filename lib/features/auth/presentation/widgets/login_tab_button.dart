import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginTabButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const LoginTabButton({
    super.key,
    required this.text,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(child: InkWell(
        onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF9E1B42) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: isActive ? Colors.transparent : Colors.black12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,color: isActive ? Colors.white : Colors.grey[600],size: 16,),
            const SizedBox(width: 6,),
            Text(text,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey[700],
              fontWeight: FontWeight.bold,
              fontSize: 13
            ),)
          ],
        ),
      ),
    ));
  }
}
