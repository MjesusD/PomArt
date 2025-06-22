import 'dart:async';  
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pomart/widgets/pomodoro_controls.dart';
import 'package:pomart/widgets/timer_display.dart';
import 'package:pomart/widgets/digital_timer_picker.dart';
import 'package:pomart/widgets/tag_selector.dart';
import 'package:pomart/entity/daily_theme.dart';
import 'package:pomart/entity/custom_tag.dart';
import 'package:pomart/entity/app_settings.dart';
import 'package:pomart/entity/session_entry.dart';
import 'package:pomart/widgets/drawer.dart';  

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
  Timer? _timer;

  double _volume = 1.0;
  String _selectedMusic = 'music/music1.mp3';
  String _selectedTag = 'Boceto';
  bool _isAddingCustomTag = false;
  final TextEditingController _tagController = TextEditingController();
  Color _customColor = Colors.blueAccent;

  final List<String> _musicOptions = [
    'music/music1.mp3',
    'music/music2.mp3',
    'music/music3.mp3',
    'music/music4.mp3',
  ];

  final DailyTheme _dailyTheme = DailyTheme();
  late final AudioPlayer _audioPlayer;
  final List<CustomTag> _customTags = [];
  final Map<String, Color> _defaultTags = {
    'Boceto': Colors.deepPurple,
    'Pintura': Colors.teal,
    'Digital': Colors.redAccent,
  };

  Map<String, Color> get _tagColors {
    final custom = {for (var tag in _customTags) tag.name: tag.color};
    return {..._defaultTags, ...custom};
  }

  late VoidCallback _settingsListener;
  late AppSettings _settings;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _loadCustomTags();

    _settings = Provider.of<AppSettings>(context, listen: false);

    _settingsListener = () {
      if (!mounted) return;
      if (!_settings.isMusicEnabled && _isRunning) {
        _pauseMusic();
      }
    };
    _settings.addListener(_settingsListener);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    _tagController.dispose();
    _settings.removeListener(_settingsListener);
    super.dispose();
  }

  Future<void> _loadCustomTags() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('customTags') ?? [];
    if (!mounted) return;
    setState(() {
      _customTags.clear();
      _customTags.addAll(saved.map((e) => CustomTag.fromStorageString(e)));
    });
  }

  Future<void> _saveCustomTags() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _customTags.map((e) => e.toStorageString()).toList();
    await prefs.setStringList('customTags', data);
  }

  Future<void> _saveSessionEntry() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> stored = prefs.getStringList('session_entries') ?? [];

    int elapsedSeconds = pomodoroDuration - _remainingSeconds;
    int elapsedMinutes = (elapsedSeconds / 60).round();

    if (elapsedMinutes < 1) elapsedMinutes = 1;

    final entry = SessionEntry(
      date: DateTime.now(),
      minutes: elapsedMinutes,
      theme: _dailyTheme.getThemeToday(),
    );

    stored.add(jsonEncode(entry.toJson()));
    await prefs.setStringList('session_entries', stored);
  }

  Future<void> _playMusic() async {
    try {
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.setVolume(_volume);
      await _audioPlayer.play(AssetSource(_selectedMusic));
    } catch (e) {
      debugPrint('Error al reproducir música: $e');
    }
  }

  Future<void> _pauseMusic() async {
    try {
      await _audioPlayer.pause();
    } catch (e) {
      debugPrint('Error al pausar música: $e');
    }
  }

  void _startTimer() async {
    if (_isRunning) return;

    setState(() => _isRunning = true);

    if (_settings.isMusicEnabled) {
      await _audioPlayer.stop(); // Reinicia música en caso de cambio de pista
      await _playMusic();
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
        setState(() => _isRunning = false);
        _pauseMusic();
        _saveSessionEntry();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Tiempo terminado!')),
        );
      }
    });
  }


  void _pauseTimer() {
    _timer?.cancel();
    if (!mounted) return;
    setState(() => _isRunning = false);
    _pauseMusic();
  }

  void _resetTimer() {
    _timer?.cancel();
    if (!mounted) return;
    setState(() {
      _remainingSeconds = pomodoroDuration;
      _isRunning = false;
    });
    _pauseMusic();
  }

  void _createCustomTag() async {
    final name = _tagController.text.trim();
    if (name.isEmpty || _tagColors.containsKey(name)) return;
    if (!mounted) return;
    setState(() {
      final newTag = CustomTag(name: name, color: _customColor);
      _customTags.add(newTag);
      _selectedTag = name;
      _isAddingCustomTag = false;
      _tagController.clear();
    });
    await _saveCustomTags();
  }

  void _showColorPickerForTag(CustomTag tag) async {
    Color pickedColor = tag.color;
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Selecciona un color para "${tag.name}"'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: pickedColor,
              onColorChanged: (color) {
                pickedColor = color;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (!mounted) return;
                setState(() {
                  final index = _customTags.indexWhere((t) => t.name == tag.name);
                  if (index != -1) {
                    _customTags[index] = CustomTag(name: tag.name, color: pickedColor);
                  }
                });
                _saveCustomTags();
                Navigator.pop(context);
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color currentColor = _tagColors[_selectedTag] ?? Colors.grey;
    final String todayTopic = _dailyTheme.getThemeToday();
    final settings = Provider.of<AppSettings>(context);

    final timerWidget = settings.timerDisplayMode == 'circle'
        ? TimerDisplay(
            remainingSeconds: _remainingSeconds,
            color: currentColor,
            isRunning: _isRunning,
            onTimeChanged: (int minutes) {
              if (!_isRunning && mounted) {
                setState(() => _remainingSeconds = minutes * 60);
              }
            },
          )
        : DigitalTimerPicker(
            initialSeconds: _remainingSeconds,
            color: currentColor,
            onTimeChanged: (int seconds) {
              if (!_isRunning && mounted) {
                setState(() => _remainingSeconds = seconds);
              }
            },
          );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          if (settings.isMusicEnabled) ...[
            IconButton(
              icon: const Icon(Icons.music_note),
              color: Theme.of(context).colorScheme.onPrimary,
              tooltip: 'Seleccionar música',
              onPressed: () async {
                final selected = await showDialog<String>(
                  context: context,
                  builder: (dialogContext) => SimpleDialog(
                    title: const Text('Selecciona música'),
                    children: _musicOptions.map((path) {
                      return SimpleDialogOption(
                        onPressed: () => Navigator.pop(dialogContext, path),
                        child: Text(path.split('/').last),
                      );
                    }).toList(),
                  ),
                );
                if (!mounted) return;
                if (selected != null && selected != _selectedMusic) {
                  setState(() => _selectedMusic = selected);
                  if (_isRunning) await _playMusic();
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.volume_up),
              color: Theme.of(context).colorScheme.onPrimary,
              tooltip: 'Ajustar volumen',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Volumen'),
                    content: StatefulBuilder(
                      builder: (context, setDialogState) => Slider(
                        min: 0,
                        max: 1,
                        divisions: 10,
                        value: _volume,
                        onChanged: (value) {
                          setState(() => _volume = value);
                          setDialogState(() {});
                          _audioPlayer.setVolume(_volume);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ],
      ),

      drawer: const AppDrawer(currentRoute: '/timer'), 
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Tema de hoy:', style: Theme.of(context).textTheme.titleMedium),
              Text(
                todayTopic,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: currentColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              TagSelector(
                selectedTag: _selectedTag,
                tagColors: _tagColors,
                onTagSelected: (tag) => setState(() => _selectedTag = tag),
                onAddCustomTag: () => setState(() => _isAddingCustomTag = true),
                onDeleteTag: (tag) async {
                  if (_defaultTags.containsKey(tag)) return; // no borrar predeterminadas
                  if (!mounted) return;
                  setState(() {
                    _customTags.removeWhere((t) => t.name == tag);
                    if (_selectedTag == tag) {
                      _selectedTag = _tagColors.keys.first;
                    }
                  });
                  await _saveCustomTags();
                },
                onEditTagColor: (tag) => _showColorPickerForTag(
                  _customTags.firstWhere((t) => t.name == tag, orElse: () => CustomTag(name: tag, color: Colors.grey)),
                ),
              ),
              if (_isAddingCustomTag) ...[
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _tagController,
                        decoration: const InputDecoration(hintText: 'Nombre de etiqueta'),
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () async {
                        final pickedColor = await showDialog<Color>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Selecciona un color'),
                            content: SingleChildScrollView(
                              child: BlockPicker(
                                pickerColor: _customColor,
                                onColorChanged: (color) => _customColor = color,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, _customColor),
                                child: const Text('Aceptar'),
                              ),
                            ],
                          ),
                        );
                        if (pickedColor != null && mounted) {
                          setState(() => _customColor = pickedColor);
                        }
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _customColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _createCustomTag,
                      child: const Text('Crear'),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 24),
              timerWidget,
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
      ),
    );
  }
}
