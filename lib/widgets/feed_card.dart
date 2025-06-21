import 'package:flutter/material.dart';
import 'package:pomart/entity/feed_item.dart';

class FeedCard extends StatelessWidget {
  final FeedItem item;

  const FeedCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (item.image.startsWith('http') || item.image.startsWith('https')) {
      imageWidget = Image.network(
        item.image,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 80),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            ),
          );
        },
      );
    } else {
     
      imageWidget = Image(
        image: AssetImage(item.image),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.broken_image, size: 80),
      );
    }

    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: imageWidget,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.user, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(item.title, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 4),
                Text('Tiempo usado: ${item.timeUsed}'),
                const SizedBox(height: 6),
                Text(item.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
