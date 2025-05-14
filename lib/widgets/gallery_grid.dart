import 'package:flutter/material.dart';

class GalleryGrid extends StatelessWidget {
  final List<String> images;

  const GalleryGrid({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        shrinkWrap: true,
        children: images
            .map((img) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
