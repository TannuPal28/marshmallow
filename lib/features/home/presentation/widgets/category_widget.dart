import 'package:flutter/cupertino.dart';

class CategoryWidget extends StatelessWidget {
  final String image;
  final String title;

  const CategoryWidget({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: 100,
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
