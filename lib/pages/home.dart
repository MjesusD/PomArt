import 'package:flutter/material.dart';
import 'package:pomart/pages/timer.dart';
import 'package:pomart/pages/profile.dart';
import 'package:pomart/pages/calendar.dart';
import 'package:pomart/pages/cronoline.dart';
import 'package:pomart/widgets/feed_view.dart';
import 'package:pomart/pages/preferences.dart';
import 'package:pomart/entity/daily_theme.dart';
import 'package:pomart/pages/about.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final dailyTheme = DailyTheme();
    final themeToday = dailyTheme.getThemeToday();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Column(
        children: [
          // Espacio para mostrar el tema grande
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            color: colorScheme.primaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tema de hoy',
                  style: textTheme.headlineSmall?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  themeToday,
                  style: textTheme.displaySmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // FeedView con Expanded para que use el resto del espacio
          const Expanded(child: FeedView()),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/logo2.png'),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'POMART',
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Pantalla de inicio'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: 'PomArt'),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Perfil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(title: 'Perfil'),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Temporizador'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TimerPage(title: 'Temporizador'),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Calendario'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CalendarPage(title: 'Calendario'),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Línea Cronológica'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CronolinePage(title: 'Linea Cronológica'),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Preferencias'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Preferences(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Acerca de'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: const AssetImage('assets/images/logo2.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(width: 12),
                  const Text('Información'),
                ],
              ),
              content: const SingleChildScrollView(
                child: Text(
                  'PomArt es una app para ayudarte a mantener la concentración y creatividad '
                  'usando técnicas Pomodoro con temas artísticos diarios y seguimiento visual de tus sesiones.',
                  textAlign: TextAlign.justify,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cerrar'),
                ),
              ],
            ),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: ClipOval(
          child: Image.asset(
            'assets/images/logo2.png',
            width: 30,
            height: 30,
            fit: BoxFit.cover,
          ),
        ),
      ),

    );
  }
}
