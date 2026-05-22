import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marshmallow/features/home/presentation/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin{
  double progress= 0.0;

  @override
  void initState() {
    super.initState();
    startLoading();
  }
  void startLoading() {
    Timer.periodic(const Duration(milliseconds: 80), (timer){

      setState(() {
        progress +=0.02;
      });
      if(progress>=1){
        timer.cancel();
        
        Future.delayed(const Duration(milliseconds: 400),(){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient( begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            colors: [

              Color(0xff9d1147),
              Color(0xff1f6fff),
              Color(0xffd9d9d9),

            ],)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,

              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),

              child: Center(
                child: Icon(
                  Icons.shopping_bag_outlined,
                  color: Color(0xffa50034),
                  size: 40,
                ),
              ),
            ),
            const SizedBox(height: 30,),
            RichText(

              text: const TextSpan(

                children: [

                  TextSpan(
                    text: "Shopping",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  TextSpan(
                    text: " Cart",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40,),

            SizedBox(width: 40,
            height: 40,

            child: CircularProgressIndicator(
              strokeWidth: 4,
              color: Colors.red.shade700,
            ),),

            const SizedBox(height: 40,),

            // PROGRESS BAR
            Container(

              width: 220,
              height: 6,

              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Align(

                alignment: Alignment.centerLeft,

                child: AnimatedContainer(

                  duration: const Duration(milliseconds: 100),

                  width: 220 * progress,

                  decoration: BoxDecoration(
                    color: const Color(0xffb4003b),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              "Almost ready...",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }


}
