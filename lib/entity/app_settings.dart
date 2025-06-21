import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomart/theme/green_theme.dart' as green;
import 'package:pomart/theme/violet_theme.dart' as violet;

enum AppColorTheme { green, violet }

class AppSettings extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  String timerDisplayMode = 'circle';
  bool isMusicEnabled = true;
  double musicVolume = 1.0;
  AppColorTheme selectedColorTheme = AppColorTheme.violet;

  static const _greenMaterialTheme = green.MaterialTheme(TextTheme());
  static const _violetMaterialTheme = violet.MaterialTheme(TextTheme());

  // SharedPreferences keys
  static const _keyThemeMode = 'themeMode';
  static const _keyTimerDisplay = 'timerDisplayMode';
  static const _keyMusicEnabled = 'musicEnabled';
  static const _keyMusicVolume = 'musicVolume';
  static const _keyColorTheme = 'colorTheme';

  AppSettings() {
    _loadPreferences();
  }

  dynamic get currentMaterialTheme {
    switch (selectedColorTheme) {
      case AppColorTheme.green:
        return _greenMaterialTheme;
      case AppColorTheme.violet:
        return _violetMaterialTheme; 
    }
  }

  ThemeData get lightTheme => currentMaterialTheme.light();
  ThemeData get darkTheme => currentMaterialTheme.dark();

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    // Cargar themeMode
    final themeIndex = prefs.getInt(_keyThemeMode) ?? 0;
    themeMode = ThemeMode.values[themeIndex];

    // Cargar timer display
    timerDisplayMode = prefs.getString(_keyTimerDisplay) ?? 'circle';

    // Cargar música
    isMusicEnabled = prefs.getBool(_keyMusicEnabled) ?? true;
    musicVolume = prefs.getDouble(_keyMusicVolume) ?? 1.0;

    // Cargar color theme
    final colorThemeIndex = prefs.getInt(_keyColorTheme) ?? 1;
    selectedColorTheme = AppColorTheme.values[colorThemeIndex];

    notifyListeners();
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(_keyThemeMode, themeMode.index);
    await prefs.setString(_keyTimerDisplay, timerDisplayMode);
    await prefs.setBool(_keyMusicEnabled, isMusicEnabled);
    await prefs.setDouble(_keyMusicVolume, musicVolume);
    await prefs.setInt(_keyColorTheme, selectedColorTheme.index);
  }

  void setThemeMode(ThemeMode mode) {
    themeMode = mode;
    _savePreferences();
    notifyListeners();
  }

  void toggleTheme(bool isDark) {
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _savePreferences();
    notifyListeners();
  }

  void setTimerDisplay(String mode) {
    timerDisplayMode = mode;
    _savePreferences();
    notifyListeners();
  }

  void setMusicEnabled(bool enabled) {
    isMusicEnabled = enabled;
    _savePreferences();
    notifyListeners();
  }

  void setMusicVolume(double volume) {
    musicVolume = volume.clamp(0.0, 1.0);
    _savePreferences();
    notifyListeners();
  }

  void setColorTheme(AppColorTheme theme) {
    if (selectedColorTheme != theme) {
      selectedColorTheme = theme;
      _savePreferences();
      notifyListeners();
    }
  }
}
