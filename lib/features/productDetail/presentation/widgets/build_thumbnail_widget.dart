import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuildThumbnailWidget extends StatelessWidget {
  String url;
  bool isSelected;

  BuildThumbnailWidget({
    super.key,
    required this.url,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(color: isSelected ? Colors.red : Colors.grey[300]!, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Image.network(url, width: 50, height: 50),
    );
  }
}
