import 'package:flutter/material.dart';
import 'package:pomart/pages/splash.dart';
import 'package:pomart/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final materialTheme = MaterialTheme(ThemeData.light().textTheme); 

    return MaterialApp(
      theme: materialTheme.light(),         // Tema claro
      //darkTheme: materialTheme.dark(),   // Tema oscuro
      //themeMode: ThemeMode.system,      // Sistema operativo decide
      home: const SplashPage(),
    );
  }
}
