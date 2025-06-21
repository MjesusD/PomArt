import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomart/entity/user_profile.dart';

class EditProfilePage extends StatefulWidget {
  final UserProfile profile;

  const EditProfilePage({super.key, required this.profile});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late TextEditingController _ageController;
  File? _imageFile;
  List<String> _galleryImages = [];

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    _bioController = TextEditingController(text: widget.profile.bio);
    _ageController = TextEditingController(text: widget.profile.age.toString());
    _galleryImages = List<String>.from(widget.profile.galleryImages);
    _loadImageFileAsync();
  }

  Future<void> _loadImageFileAsync() async {
    final path = widget.profile.profileImage;
    if (path.isNotEmpty && !path.startsWith('assets/')) {
      final file = File(path);
      final exists = await file.exists();
      if (exists) {
        setState(() {
          _imageFile = file;
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final int age = int.tryParse(_ageController.text) ?? 0;

    await prefs.setString('username', _nameController.text);
    await prefs.setString('bio', _bioController.text);
    await prefs.setInt('age', age);
    await prefs.setStringList('galleryImages', _galleryImages);

    if (_imageFile != null) {
      await prefs.setString('profileImagePath', _imageFile!.path);
    } else {
      await prefs.remove('profileImagePath');
    }

    if (!mounted) return;

    Navigator.pop(
      context,
      UserProfile(
        name: _nameController.text,
        age: age,
        bio: _bioController.text,
        profileImage: _imageFile?.path ?? '',
        minutesUsed: widget.profile.minutesUsed,
        galleryImages: _galleryImages,
      ),
    );
  }

  Widget _buildProfileImage() {
    if (_imageFile != null) {
      return ClipOval(
        child: Image.file(_imageFile!, fit: BoxFit.cover, width: 120, height: 120),
      );
    }
    return CircleAvatar(
      radius: 60,
      backgroundColor: Colors.grey[300],
      child: const Icon(Icons.person, size: 80, color: Colors.white),
    );
  }

  void _removeImage(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar imagen'),
        content: const Text('¿Estás seguro de que deseas eliminar esta imagen de tu galería?'),
        actions: [
          TextButton(
            child: Text('Cancelar', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Eliminar', style: TextStyle(color: Theme.of(context).colorScheme.error)),
            onPressed: () {
              setState(() {
                _galleryImages.removeAt(index);
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryGrid() {
    if (_galleryImages.isEmpty) {
      return const Center(child: Text('Aún no has subido imágenes.'));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _galleryImages.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        final path = _galleryImages[index];
        final imageFile = File(path);
        final imageWidget = imageFile.existsSync()
            ? Image.file(imageFile, fit: BoxFit.cover)
            : const Icon(Icons.broken_image);

        return Stack(
          children: [
            Positioned.fill(child: imageWidget),
            Positioned(
              top: 2,
              right: 2,
              child: GestureDetector(
                onTap: () => _removeImage(index),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(Icons.close, color: Colors.white, size: 18),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Editar Perfil')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: colorScheme.primaryContainer,
                child: _buildProfileImage(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nombre'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _ageController,
            decoration: const InputDecoration(labelText: 'Edad'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _bioController,
            decoration: const InputDecoration(labelText: 'Biografía / Intereses'),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          Text(
            'Minutos invertidos: ${widget.profile.minutesUsed}',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          Text(
            'Mis imágenes:',
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildGalleryGrid(),
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
            ),
            onPressed: _saveProfile,
            child: const Text('Guardar cambios'),
          ),
        ],
      ),
    );
  }
}
