import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtpTextfieldWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final TextEditingController controller;

  const OtpTextfieldWidget({super.key,
    required this.icon,
    required this.controller, required this.title,});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10,),
            
            Text(title,style: const TextStyle(
              fontSize: 20,
              fontWeight:
              FontWeight.bold,
            ),),
          ],
        ),

        const SizedBox(height: 15,),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          maxLength: 4,
          decoration: InputDecoration(
            counterText: "",
            hintText: "Enter $title",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15)
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.pink,
                width: 2
              )
            )
          ),
        )
      ],
    );
  }
}
