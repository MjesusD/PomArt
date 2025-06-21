import 'dart:math';

class DailyTheme {
  final List<String> _themes = [
    'Naturaleza',
    'Animales',
    'Robots',
    'Comida',
    'Anime',
    'Cartoon',
    'Halloween',
  ];

  String getThemeToday() {
    final now = DateTime.now();
    final seed = now.year * 10000 + now.month * 100 + now.day;
    final rng = Random(seed);
    return _themes[rng.nextInt(_themes.length)];
  }
}
