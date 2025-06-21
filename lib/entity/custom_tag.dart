import 'package:flutter/material.dart';

class CustomTag {
  final String name;
  final Color color;

  CustomTag({required this.name, required this.color});

  // Para convertir a JSON (mapa)
  Map<String, dynamic> toJson() => {
        'name': name,
        'color': color.toARGB32(),
      };

  // Para crear desde JSON (mapa)
  factory CustomTag.fromJson(Map<String, dynamic> json) => CustomTag(
        name: json['name'] as String,
        color: Color(json['color'] as int),
      );

  // Para convertir a String simple para almacenamiento (ej: "nombre|colorHex")
  String toStorageString() {
    return '$name|${color.toARGB32().toRadixString(16)}';
  }

  // Para crear desde String simple guardado
  factory CustomTag.fromStorageString(String stored) {
    final parts = stored.split('|');
    final name = parts[0];
    final colorValue = int.tryParse(parts[1], radix: 16) ?? 0xFF000000;
    return CustomTag(name: name, color: Color(colorValue));
  }
}
