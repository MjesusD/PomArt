import 'package:flutter/material.dart';
import 'package:pomart/pages/feedback.dart';
import 'package:pomart/widgets/drawer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: const AppDrawer(currentRoute: '/about'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: const AssetImage('assets/images/logo2.png'),
                backgroundColor: colorScheme.primaryContainer,
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'PomArt',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                'Desarrollado por Manuela Duarte',
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface.withValues(),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Center(
              child: Text(
                'Contacto: manueladuartetoro04@gmail.com',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Card(
              color: colorScheme.primaryContainer,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'PomArt es una app para artistas y aficionados al dibujo que combina la técnica Pomodoro con retos creativos diarios.\n\n'
                  'Permite subir imágenes relacionadas con cada desafío, hacer seguimiento del progreso y compartir el proceso artístico con otros usuarios.\n\n'
                  'Incluye un calendario, una línea temporal y una sección de inicio con publicaciones de la comunidad para inspirarte y mantener la motivación.',
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.feedback_outlined),
                label: const Text('Valorar / Dar opinión'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FeedbackPage()),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
