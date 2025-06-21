import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff7800c8),
      surfaceTint: Color(0xff8b00e7),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9a00ff),
      onPrimaryContainer: Color(0xfff5e3ff),
      secondary: Color(0xff7c41b1),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffc588fd),
      onSecondaryContainer: Color(0xff541289),
      tertiary: Color(0xff9b0072),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffc60092),
      onTertiaryContainer: Color(0xffffe2ee),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff7fe),
      onSurface: Color(0xff201925),
      onSurfaceVariant: Color(0xff4e4356),
      outline: Color(0xff7f7288),
      outlineVariant: Color(0xffd0c1d9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff352e3a),
      inversePrimary: Color(0xffdeb7ff),
      primaryFixed: Color(0xfff1dbff),
      onPrimaryFixed: Color(0xff2d0050),
      primaryFixedDim: Color(0xffdeb7ff),
      onPrimaryFixedVariant: Color(0xff6a00b1),
      secondaryFixed: Color(0xfff1dbff),
      onSecondaryFixed: Color(0xff2d0050),
      secondaryFixedDim: Color(0xffdeb7ff),
      onSecondaryFixedVariant: Color(0xff632698),
      tertiaryFixed: Color(0xffffd8ea),
      onTertiaryFixed: Color(0xff3c002a),
      tertiaryFixedDim: Color(0xffffaed9),
      onTertiaryFixedVariant: Color(0xff890064),
      surfaceDim: Color(0xffe2d6e7),
      surfaceBright: Color(0xfffff7fe),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffcf0ff),
      surfaceContainer: Color(0xfff7eafb),
      surfaceContainerHigh: Color(0xfff1e4f5),
      surfaceContainerHighest: Color(0xffebdeef),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff52008c),
      surfaceTint: Color(0xff8b00e7),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9a00ff),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff510b86),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff8c51c2),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff6b004e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffc60092),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff7fe),
      onSurface: Color(0xff150f1a),
      onSurfaceVariant: Color(0xff3c3245),
      outline: Color(0xff5a4e62),
      outlineVariant: Color(0xff75697d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff352e3a),
      inversePrimary: Color(0xffdeb7ff),
      primaryFixed: Color(0xff9d1cff),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff7d00d1),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff8c51c2),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff7236a7),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xffcb0d96),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xffa20077),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffcec2d3),
      surfaceBright: Color(0xfffff7fe),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffcf0ff),
      surfaceContainer: Color(0xfff1e4f5),
      surfaceContainerHigh: Color(0xffe5d9ea),
      surfaceContainerHighest: Color(0xffdacede),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff440075),
      surfaceTint: Color(0xff8b00e7),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6d00b7),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff440075),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff65299a),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff5a0040),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff8d0067),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff7fe),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff32283a),
      outlineVariant: Color(0xff504558),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff352e3a),
      inversePrimary: Color(0xffdeb7ff),
      primaryFixed: Color(0xff6d00b7),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff4d0084),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff65299a),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff4d0382),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff8d0067),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff650049),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc0b5c5),
      surfaceBright: Color(0xfffff7fe),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff9ecfe),
      surfaceContainer: Color(0xffebdeef),
      surfaceContainerHigh: Color(0xffddd0e1),
      surfaceContainerHighest: Color(0xffcec2d3),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffdeb7ff),
      surfaceTint: Color(0xffdeb7ff),
      onPrimary: Color(0xff4a007f),
      primaryContainer: Color(0xff9a00ff),
      onPrimaryContainer: Color(0xfff5e3ff),
      secondary: Color(0xffdeb7ff),
      onSecondary: Color(0xff4a007f),
      secondaryContainer: Color(0xff632698),
      onSecondaryContainer: Color(0xffd2a0ff),
      tertiary: Color(0xffffaed9),
      onTertiary: Color(0xff610046),
      tertiaryContainer: Color(0xffc60092),
      onTertiaryContainer: Color(0xffffe2ee),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff17111c),
      onSurface: Color(0xffebdeef),
      onSurfaceVariant: Color(0xffd0c1d9),
      outline: Color(0xff998ca2),
      outlineVariant: Color(0xff4e4356),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffebdeef),
      inversePrimary: Color(0xff8b00e7),
      primaryFixed: Color(0xfff1dbff),
      onPrimaryFixed: Color(0xff2d0050),
      primaryFixedDim: Color(0xffdeb7ff),
      onPrimaryFixedVariant: Color(0xff6a00b1),
      secondaryFixed: Color(0xfff1dbff),
      onSecondaryFixed: Color(0xff2d0050),
      secondaryFixedDim: Color(0xffdeb7ff),
      onSecondaryFixedVariant: Color(0xff632698),
      tertiaryFixed: Color(0xffffd8ea),
      onTertiaryFixed: Color(0xff3c002a),
      tertiaryFixedDim: Color(0xffffaed9),
      onTertiaryFixedVariant: Color(0xff890064),
      surfaceDim: Color(0xff17111c),
      surfaceBright: Color(0xff3e3643),
      surfaceContainerLowest: Color(0xff120c17),
      surfaceContainerLow: Color(0xff201925),
      surfaceContainer: Color(0xff241d29),
      surfaceContainerHigh: Color(0xff2e2734),
      surfaceContainerHighest: Color(0xff39323f),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffedd3ff),
      surfaceTint: Color(0xffdeb7ff),
      onPrimary: Color(0xff3b0067),
      primaryContainer: Color(0xffb96cff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffedd3ff),
      onSecondary: Color(0xff3b0067),
      secondaryContainer: Color(0xffb275e9),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffcfe6),
      onTertiary: Color(0xff4e0037),
      tertiaryContainer: Color(0xfffa44bd),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff17111c),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffe7d7ef),
      outline: Color(0xffbbadc4),
      outlineVariant: Color(0xff998ba1),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffebdeef),
      inversePrimary: Color(0xff6b00b4),
      primaryFixed: Color(0xfff1dbff),
      onPrimaryFixed: Color(0xff1e0038),
      primaryFixedDim: Color(0xffdeb7ff),
      onPrimaryFixedVariant: Color(0xff52008c),
      secondaryFixed: Color(0xfff1dbff),
      onSecondaryFixed: Color(0xff1e0038),
      secondaryFixedDim: Color(0xffdeb7ff),
      onSecondaryFixedVariant: Color(0xff510b86),
      tertiaryFixed: Color(0xffffd8ea),
      onTertiaryFixed: Color(0xff29001c),
      tertiaryFixedDim: Color(0xffffaed9),
      onTertiaryFixedVariant: Color(0xff6b004e),
      surfaceDim: Color(0xff17111c),
      surfaceBright: Color(0xff4a414f),
      surfaceContainerLowest: Color(0xff0a0510),
      surfaceContainerLow: Color(0xff221b27),
      surfaceContainer: Color(0xff2c2532),
      surfaceContainerHigh: Color(0xff37303d),
      surfaceContainerHighest: Color(0xff433b48),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff9ebff),
      surfaceTint: Color(0xffdeb7ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffdcb2ff),
      onPrimaryContainer: Color(0xff16002b),
      secondary: Color(0xfff9ebff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffdcb2ff),
      onSecondaryContainer: Color(0xff16002b),
      tertiary: Color(0xffffebf2),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffffa8d7),
      onTertiaryContainer: Color(0xff1f0014),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff17111c),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff9ebff),
      outlineVariant: Color(0xffccbdd5),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffebdeef),
      inversePrimary: Color(0xff6b00b4),
      primaryFixed: Color(0xfff1dbff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffdeb7ff),
      onPrimaryFixedVariant: Color(0xff1e0038),
      secondaryFixed: Color(0xfff1dbff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffdeb7ff),
      onSecondaryFixedVariant: Color(0xff1e0038),
      tertiaryFixed: Color(0xffffd8ea),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffffaed9),
      onTertiaryFixedVariant: Color(0xff29001c),
      surfaceDim: Color(0xff17111c),
      surfaceBright: Color(0xff554d5b),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff241d29),
      surfaceContainer: Color(0xff352e3a),
      surfaceContainerHigh: Color(0xff403946),
      surfaceContainerHighest: Color(0xff4c4451),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
