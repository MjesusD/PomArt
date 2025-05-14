import 'package:flutter/material.dart';
import 'package:pomart/widgets/pomodoro_controls.dart';
import 'package:pomart/widgets/timer_display.dart';
import 'package:pomart/entity/daily_theme.dart'; 


class TimerPage extends StatefulWidget {
  const TimerPage({super.key, required this.title});
  final String title;

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  static const int pomodoroDuration = 25 * 60;
  int _remainingSeconds = pomodoroDuration;
  bool _isRunning = false;

  final DailyTheme _dailyTheme = DailyTheme(); 

  final Map<String, Color> _tagColors = {
    'Enfoque': Colors.deepPurple,
    'Relajado': Colors.teal,
    'Intenso': Colors.redAccent,
    'Creativo': Colors.orange,
  };

  String _selectedTag = 'Enfoque';

  void _startTimer() {
    setState(() => _isRunning = true);
    
  }

  void _pauseTimer() {
    setState(() => _isRunning = false);
  }

  void _resetTimer() {
    setState(() {
      _remainingSeconds = pomodoroDuration;
      _isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color currentColor = _tagColors[_selectedTag]!;
    final String todayTopic = _dailyTheme.getThemeToday();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.music_note),
            tooltip: 'Música',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Música activada')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.volume_up),
            tooltip: 'Volumen',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Volumen ajustado')),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Tema de hoy:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              todayTopic,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: currentColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            // Selector de etiqueta
            Wrap(
              spacing: 10,
              children: _tagColors.keys.map((tag) {
                final isSelected = tag == _selectedTag;
                return ChoiceChip(
                  label: Text(tag),
                  selected: isSelected,
                  selectedColor: _tagColors[tag]!.withAlpha((255 * 0.3).round()),
                  backgroundColor: Colors.grey[200],
                  onSelected: (_) {
                    setState(() => _selectedTag = tag);
                  },
                  labelStyle: TextStyle(
                    color: isSelected ? _tagColors[tag] : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            // Reloj
            TimerDisplay(
              remainingSeconds: _remainingSeconds,
              color: currentColor,
            ),
            const SizedBox(height: 30),
            PomodoroControls(
              isRunning: _isRunning,
              onStart: _startTimer,
              onPause: _pauseTimer,
              onReset: _resetTimer,
            ),
          ],
        ),
      ),
    );
  }
}
