import 'package:flutter/cupertino.dart';

class BuildLabelWidget extends StatelessWidget {
 final String title;
  const BuildLabelWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,

      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Color(0xff374151),
      ),
    );
  }
}
