import 'dart:io';
import 'package:flutter/material.dart';

class GalleryGrid extends StatelessWidget {
  final List<String> images;
  final void Function(String imagePath)? onImageTap; // callback opcional

  const GalleryGrid({
    super.key,
    required this.images,
    this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const Center(
        child: Text('Aún no has subido imágenes.'),
      );
    }

    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 6,
      mainAxisSpacing: 6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: images.map((img) {
        ImageProvider imageProvider;

        if (img.startsWith('assets/')) {
          imageProvider = AssetImage(img);
        } else {
          final file = File(img);
          imageProvider = FileImage(file);
        }

        return GestureDetector(
          onTap: () {
            if (onImageTap != null) {
              onImageTap!(img);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
        );
      }).toList(),
    );
  }
}
