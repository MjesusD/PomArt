import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomart/pages/splash.dart';
import 'package:pomart/pages/home.dart';
import 'package:pomart/pages/profile.dart';
import 'package:pomart/pages/timer.dart';
import 'package:pomart/pages/calendar.dart';
import 'package:pomart/pages/cronoline.dart';
import 'package:pomart/pages/preferences.dart';
import 'package:pomart/pages/about.dart';
import 'package:pomart/entity/app_settings.dart';

final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppSettings(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AppSettings>(context);

    return MaterialApp(
      theme: settings.lightTheme,
      darkTheme: settings.darkTheme,
      themeMode: settings.themeMode,
      navigatorObservers: [routeObserver],
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/home': (context) => const MyHomePage(title: 'Pantalla de Inicio'),
        '/profile': (context) => const ProfilePage(title: 'Perfil'),
        '/timer': (context) => const TimerPage(title: 'Temporizador'),
        '/calendar': (context) => const CalendarPage(title: 'Calendario'),
        '/cronoline': (context) => const CronolinePage(title: 'Línea Cronológica'),
        '/preferences': (context) => const Preferences(),
        '/about': (context) => const AboutPage(),
      },
    );
  }
}
