import 'dart:io'; 
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomart/entity/user_profile.dart';
import 'package:pomart/pages/edit_profile.dart';
import 'package:pomart/widgets/drawer.dart';
import 'package:pomart/widgets/weekly_streak.dart';
import 'package:pomart/entity/session_entry.dart';
import 'package:pomart/pages/image_preview.dart';

class ProfilePage extends StatefulWidget {
  final String title;

  const ProfilePage({super.key, required this.title});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserProfile? profile;
  int streak = 0; // Racha semanal

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
    _calculateStreakFromSessions();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');

    if (username == null || username.isEmpty) {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/login');
      return;
    }

    final bio = prefs.getString('bio') ?? 'Bienvenido a tu perfil de PomArt';
    final imagePath = prefs.getString('profileImagePath') ?? '';
    final images = prefs.getStringList('galleryImages') ?? [];
    final minutesUsed = prefs.getInt('minutesUsed') ?? 0;
    final age = prefs.getInt('age') ?? 0;

    String validImagePath = '';
    if (imagePath.isNotEmpty) {
      final file = File(imagePath);
      if (await file.exists()) {
        validImagePath = imagePath;
      }
    }

    if (!mounted) return;

    setState(() {
      profile = UserProfile(
        name: username,
        age: age,
        bio: bio,
        profileImage: validImagePath,
        minutesUsed: minutesUsed,
        galleryImages: images,
      );
    });
  }

  Future<void> _calculateStreakFromSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList('session_entries') ?? [];

    final sessions = stored
        .map((e) => SessionEntry.fromJson(jsonDecode(e)))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date)); // Orden descendente

    if (!mounted) return;

    final calculatedStreak = _calculateStreak(sessions);

    setState(() {
      streak = calculatedStreak;
    });

    await prefs.setInt('weeklyStreak', calculatedStreak);
  }

  int _calculateStreak(List<SessionEntry> sessions) {
    if (sessions.isEmpty) return 0;

    List<DateTime> dates = sessions
        .map((s) => DateTime(s.date.year, s.date.month, s.date.day))
        .toSet()
        .toList();

    dates.sort((a, b) => b.compareTo(a)); // Orden descendente

    int streakCount = 1;
    DateTime currentDay = dates[0];

    for (int i = 1; i < dates.length; i++) {
      final diff = currentDay.difference(dates[i]).inDays;

      if (diff == 1) {
        streakCount++;
        currentDay = dates[i];
      } else if (diff > 1) {
        break;
      }
    }

    if (streakCount > 7) {
      streakCount = streakCount % 7;
    }

    return streakCount;
  }

  Future<void> _handleMenuSelection(String value) async {
    switch (value) {
      case 'edit':
        if (profile == null) return;
        final updatedProfile = await Navigator.push<UserProfile>(
          context,
          MaterialPageRoute(
            builder: (context) => EditProfilePage(profile: profile!),
          ),
        );
        if (!mounted) return;
        if (updatedProfile != null) {
          setState(() {
            profile = updatedProfile;
          });
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: colorScheme.onPrimary),
        ),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            iconColor: colorScheme.onPrimary,
            onSelected: _handleMenuSelection,
            itemBuilder: (context) => const [
              PopupMenuItem<String>(
                value: 'edit',
                child: Text('Editar perfil'),
              ),
            ],
          ),
        ],
      ),
      drawer: const AppDrawer(currentRoute: '/profile'),
      body: profile == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: colorScheme.primaryContainer,
                    backgroundImage: profile!.profileImage.isNotEmpty
                        ? FileImage(File(profile!.profileImage))
                        : null,
                    child: profile!.profileImage.isEmpty
                        ? Icon(Icons.person,
                            size: 50, color: colorScheme.onPrimaryContainer)
                        : null,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    profile!.name,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Edad: ${profile!.age} años',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    profile!.bio,
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  if (streak > 0) ...[
                    const SizedBox(height: 16),
                    WeeklyStreak(daysCompleted: streak > 7 ? 7 : streak),
                    const SizedBox(height: 8),
                    Text(
                      'Racha de uso: $streak día${streak > 1 ? 's' : ''}',
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],

                  const Divider(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.timer_outlined, color: colorScheme.primary),
                      const SizedBox(width: 8),
                      Text(
                        '${profile!.minutesUsed} minutos usando la app',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Tu progreso',
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  profile!.galleryImages.isEmpty
                      ? Text(
                          'Aún no publicas tus obras',
                          style: TextStyle(color: colorScheme.onSurface),
                        )
                      : GridView.count(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          physics: const NeverScrollableScrollPhysics(),
                          children: profile!.galleryImages.map((imgPath) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ImagePreviewPage(imagePath: imgPath),
                                  ),
                                );
                              },
                              child: Image.file(
                                File(imgPath),
                                fit: BoxFit.cover,
                              ),
                            );
                          }).toList(),
                        ),
                ],
              ),
            ),
    );
  }
}
