import 'package:flutter/material.dart';
import 'package:pomart/pages/splash.dart';


void main() {
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POMART APP',
      theme: ThemeData(
        appBarTheme: const AppBarTheme( backgroundColor: Color.fromARGB(255, 212, 173, 235)),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 187, 128, 221)),
      ),
      home: const SplashPage(),
    );
  }
}

