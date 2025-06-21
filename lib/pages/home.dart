import 'package:flutter/material.dart';
import 'package:pomart/widgets/drawer.dart';  
import 'package:pomart/widgets/feed_view.dart';
import 'package:pomart/entity/daily_theme.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

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
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 4,
        shadowColor: Colors.black.withAlpha(100),
      ),
      body: Column(
        children: [
          // Tema del día visual
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorScheme.primaryContainer,
                  colorScheme.secondaryContainer,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(100),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
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
          const SizedBox(height: 16),
          // Feed de contenido
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: FeedView(),
            ),
          ),
        ],
      ),

      drawer: const AppDrawer(currentRoute: '/home'),  // Usa el drawer con ruta actual

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/images/logo2.png'),
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
        backgroundColor: colorScheme.primary,
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
