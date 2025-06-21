import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomart/entity/app_settings.dart';
import 'package:pomart/widgets/drawer.dart'; 

class Preferences extends StatelessWidget {
  const Preferences({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AppSettings>(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Preferencias',
          style: TextStyle(color: colorScheme.onPrimary),
        ),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: const AppDrawer(currentRoute: '/preferences'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Modo oscuro
          SwitchListTile(
            title: Text('Modo oscuro', style: textTheme.bodyLarge),
            value: settings.themeMode == ThemeMode.dark,
            onChanged: (val) => settings.toggleTheme(val),
            activeColor: colorScheme.primary,
          ),

          // Música de fondo
          SwitchListTile(
            title: Text('Música de fondo', style: textTheme.bodyLarge),
            value: settings.isMusicEnabled,
            onChanged: (val) => settings.setMusicEnabled(val),
            activeColor: colorScheme.primary,
          ),

          // Volumen
          if (settings.isMusicEnabled)
            ListTile(
              title: Text('Volumen de la música', style: textTheme.bodyLarge),
              subtitle: Slider(
                value: settings.musicVolume,
                min: 0,
                max: 1,
                divisions: 10,
                label: '${(settings.musicVolume * 100).round()}%',
                onChanged: (value) => settings.setMusicVolume(value),
                activeColor: colorScheme.primary,
              ),
            ),

          // Modo de visualización del temporizador
          ListTile(
            title: Text('Modo de visualización del timer', style: textTheme.bodyLarge),
            trailing: DropdownButton<String>(
              value: settings.timerDisplayMode,
              items: const [
                DropdownMenuItem(value: 'circle', child: Text('Circular')),
                DropdownMenuItem(value: 'digital', child: Text('Predeterminado')),
              ],
              onChanged: (mode) {
                if (mode != null) settings.setTimerDisplay(mode);
              },
            ),
          ),

          // Selección del tema de color
          ListTile(
            title: Text('Tema de color', style: textTheme.bodyLarge),
            trailing: DropdownButton<AppColorTheme>(
              value: settings.selectedColorTheme,
              items: AppColorTheme.values.map((theme) {
                return DropdownMenuItem(
                  value: theme,
                  child: Text(_getThemeName(theme)),
                );
              }).toList(),
              onChanged: (theme) {
                if (theme != null) settings.setColorTheme(theme);
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getThemeName(AppColorTheme theme) {
    switch (theme) {
      case AppColorTheme.green:
        return 'Aspecto 1';
      case AppColorTheme.violet:
        return 'Aspecto 2';
    }
  }
}
