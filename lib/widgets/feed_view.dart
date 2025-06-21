import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomart/entity/feed_item.dart';
import 'package:pomart/widgets/feed_card.dart';
import '../entity/daily_theme.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  String? _themeToday;
  final _dailyTheme = DailyTheme();

  final Map<String, List<String>> _assetsPorTema = {
    'Anime': [
      'assets/images/anime/image1.png',
      'assets/images/anime/image2.png',
      'assets/images/anime/image3.png',
    ],
    'Animales': [
      'assets/images/animals/animal1.jpg',
      'assets/images/animals/animal2.jpg',
      'assets/images/animals/animal3.jpg',
    ],
    'Robots': [
      'assets/images/robots_t/robot1.jpg',
      'assets/images/robots_t/robot2.jpg',
      'assets/images/robots_t/robot3.jpg',
    ],
    'Comida': [
      'assets/images/food/comida1.jpg',
      'assets/images/food/comida2.jpg',
      'assets/images/food/comida3.png',
    ],
    'Halloween': [
      'assets/images/halloween/hallo2.jpg',
      'assets/images/halloween/hallo3.jpg',
      'assets/images/halloween/hallo4.jpg',
    ],
    'Naturaleza': [
      'assets/images/nature/plantas1.jpg',
      'assets/images/nature/plantas2.jpg',
      'assets/images/nature/plantas3.jpg',
    ],
    'Cartoon': [
      'assets/images/cartoon/cartoon1.jpg',
      'assets/images/cartoon/cartoon2.jpg',
      'assets/images/cartoon/cartoon3.jpg',
    ],
  };

  @override
  void initState() {
    super.initState();
    _loadOrSetTheme();
  }

  Future<void> _loadOrSetTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final todayKey = '${now.year}-${now.month}-${now.day}';

    final savedDate = prefs.getString('theme_date');
    final savedTheme = prefs.getString('theme_today');

    if (savedDate == todayKey && savedTheme != null) {
      setState(() => _themeToday = savedTheme);
    } else {
      final newTheme = _dailyTheme.getThemeToday();
      await prefs.setString('theme_today', newTheme);
      await prefs.setString('theme_date', todayKey);
      setState(() => _themeToday = newTheme);
    }
  }

  List<FeedItem> _generateFakeUsers(String theme) {
    final assets = _assetsPorTema[theme];
    if (assets == null || assets.length < 3) return [];

    final List<String> shuffled = List.from(assets)..shuffle();
    return List.generate(3, (i) {
      return FeedItem(
        user: ['UserOne', 'UserTwo', 'UserThree'][i],
        title: ['Primera obra', 'Segundo intento', 'Tercer trazo'][i],
        description: ['Descripción A', 'Descripción B', 'Descripción C'][i],
        timeUsed: ['20 min', '40 min', '60 min'][i],
        theme: theme,
        image: shuffled[i],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_themeToday == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final fakeUsers = _generateFakeUsers(_themeToday!);

    return Scaffold(
      appBar: AppBar(
        title: Text('Progreso de otros usuarios'),
      ),
      body: fakeUsers.isEmpty
          ? Center(
              child: Text(
                'No hay imágenes para el tema "$_themeToday" de hoy.',
                style: const TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: fakeUsers.length,
              itemBuilder: (context, index) =>
                  FeedCard(item: fakeUsers[index]),
            ),
    );
  }
}
