import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtpTitleWidget extends StatelessWidget {
  const OtpTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Verify OTP",style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),),
        IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.close,size: 30,),
        )
      ],
    );
  }
}
