import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pomart/entity/user_profile.dart';

class ProfileHeader extends StatelessWidget {
  final UserProfile profile;

  const ProfileHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;

    if (profile.profileImage.isEmpty) {
      imageProvider = null;
    } else if (profile.profileImage.startsWith('assets/')) {
      imageProvider = AssetImage(profile.profileImage);
    } else {
      // Asumir que el archivo existe. 
      // Si no, mostrará error visual en la imagen.
      imageProvider = FileImage(File(profile.profileImage));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: imageProvider,
            backgroundColor: Colors.grey[200],
            child: imageProvider == null
                ? const Icon(Icons.person, size: 50, color: Colors.grey)
                : null,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          profile.name,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text('Edad: ${profile.age} años', style: TextStyle(fontSize: 20, color: Colors.grey[700])),
        const SizedBox(height: 8),
        Text('Intereses: ${profile.bio}', style: TextStyle(fontSize: 18, color: Colors.grey[700])),
        const SizedBox(height: 8),
        Text('Tiempo de dibujo: ${profile.minutesUsed} minutos',
            style: TextStyle(fontSize: 18, color: Colors.grey[700])),
      ],
    );
  }
}
