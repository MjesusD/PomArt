import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomart/pages/splash.dart';
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
      home: const SplashPage(),
    );
  }
}
