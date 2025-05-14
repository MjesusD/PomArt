import 'package:flutter/material.dart';
import 'package:pomart/widgets/profile_header.dart';
import 'package:pomart/widgets/gallery_grid.dart';
import 'package:pomart/entity/user_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});
  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Perfil de ejemplo
  final UserProfile profile = UserProfile(
    name: 'Fer C',
    age: 25,
    bio: 'Programación, Diseño y Tecnología',
    profileImage: 'assets/images/profile.jpg',
    minutesUsed: 120,
    galleryImages: List.generate(6, (i) => 'assets/images/image${i + 1}.png'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Foto de perfil
            ProfileHeader(profile: profile),

            SizedBox(height: 16),

            // Contador de desafíos
            Center(
              child: ElevatedButton(
                onPressed: _incrementCounter,
                child: const Text('Desafíos completados'),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Check: $_counter',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),

            // Tabla de imágenes destacadas
            const Text(
              'Mi progreso:',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // Flexible para que el GridView no cause overflow
            GalleryGrid(images: profile.galleryImages),
          ],
        ),
      ),
    );
  }
}
