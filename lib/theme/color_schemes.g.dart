import 'package:flutter/material.dart';

// Color schemes claros
const ColorScheme blueLightScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Colors.blue,
  onPrimary: Colors.white,
  secondary: Colors.blueAccent,
  onSecondary: Colors.white,
  error: Colors.red,
  onError: Colors.white,
  surface: Colors.white,
  onSurface: Colors.black,
);

const ColorScheme greenLightScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Colors.green,
  onPrimary: Colors.white,
  secondary: Colors.greenAccent,
  onSecondary: Colors.white,
  error: Colors.red,
  onError: Colors.white,
  surface: Colors.white,
  onSurface: Colors.black,
);

// Color schemes oscuros
const ColorScheme blueDarkScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF0D47A1),
  onPrimary: Colors.white,
  secondary: Color(0xFF5472D3),
  onSecondary: Colors.white,
  error: Colors.redAccent,
  onError: Colors.black,
  surface: Color(0xFF1E1E1E),
  onSurface: Colors.white,
);

const ColorScheme greenDarkScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF1B5E20),
  onPrimary: Colors.white,
  secondary: Color(0xFF4CAF50),
  onSecondary: Colors.white,
  error: Colors.redAccent,
  onError: Colors.black,
  surface: Color(0xFF1E1E1E),
  onSurface: Colors.white,
);
