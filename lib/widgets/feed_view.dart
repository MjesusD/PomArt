// feed_view.dart
import 'package:flutter/material.dart';
import 'package:pomart/entity/feed_item.dart';
import 'package:pomart/widgets/feed_card.dart';

class FeedView extends StatelessWidget {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FeedItem> items = [
      FeedItem(
        user: 'Kid_Draw',
        title: 'Dibujo tranquilo',
        timeUsed: '45 min',
        description: 'Zutomayo',
        image: 'assets/images/user1.png',
      ),
      FeedItem(
        user: 'Mxmloon',
        title: 'Sketch',
        timeUsed: '10 min',
        description: 'Sandwich.',
        image: 'assets/images/user2.png',
      ),
      FeedItem(
        user: 'Triton',
        title: 'Top Draw',
        timeUsed: '25 min',
        description: 'Digital art practice',
        image: 'assets/images/user3.png',
      ),
      FeedItem(
        user: 'Sheldon',
        title: 'Dibujo #20',
        timeUsed: '120 min',
        description: 'Anime',
        image: 'assets/images/user4.png',
      ),
    ];

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return FeedCard(item: items[index]);
      },
    );
  }
}
