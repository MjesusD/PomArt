import 'dart:convert';
import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pomart/widgets/profile_header.dart';
import 'package:pomart/widgets/gallery_grid.dart';
import 'package:pomart/entity/user_profile.dart';
import 'package:pomart/entity/session_entry.dart';
import 'package:pomart/pages/edit_profile.dart';
import 'package:pomart/pages/image_preview.dart';

import 'package:pomart/widgets/weekly_streak.dart';


final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});
  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with RouteAware {
  int _weeklyStreak = 0;
  UserProfile? profile;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
    _loadWeeklyStreak();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    _loadUserProfile();
    _loadWeeklyStreak();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username') ?? 'Desconocido';
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

  Future<void> _loadWeeklyStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final storedSessions = prefs.getStringList('session_entries') ?? [];

    final sessionDates = storedSessions
        .map((e) => SessionEntry.fromJson(jsonDecode(e)).date)
        .toList();

    final streak = calculateWeeklyStreak(sessionDates);

    setState(() {
      _weeklyStreak = streak;
    });
  }

  int calculateWeeklyStreak(List<DateTime> sessionDates) {
    if (sessionDates.isEmpty) return 0;

    final today = DateTime.now();

    DateTime normalize(DateTime d) => DateTime(d.year, d.month, d.day);
    final normalizedToday = normalize(today);

    final uniqueDatesSet = sessionDates.map(normalize).toSet();

    int streak = 0;

    for (int i = 0; i < 7; i++) {
      final dayToCheck = normalizedToday.subtract(Duration(days: i));
      if (uniqueDatesSet.contains(dayToCheck)) {
        streak++;
      } else {
        break;
      }
    }

    return streak;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: theme.colorScheme.inversePrimary,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'edit' && profile != null) {
                final updatedProfile = await Navigator.push<UserProfile>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(profile: profile!),
                  ),
                );
                if (updatedProfile != null) {
                  setState(() {
                    profile = updatedProfile;
                  });
                }
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'edit',
                child: Text('Editar perfil'),
              ),
            ],
          ),
        ],
      ),
      body: profile == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ProfileHeader(profile: profile!),
                  const SizedBox(height: 16),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Racha semanal',
                          style: textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        WeeklyStreak(daysCompleted: _weeklyStreak > 7 ? 7 : _weeklyStreak),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Mi progreso:',
                    style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  GalleryGrid(
                    images: profile!.galleryImages,
                    onImageTap: (imagePath) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ImagePreviewPage(imagePath: imagePath),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
