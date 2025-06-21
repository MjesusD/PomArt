import 'package:flutter/material.dart';
import 'package:pomart/pages/feedback.dart';

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo centered
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: const AssetImage('assets/images/logo2.png'),
                backgroundColor: colorScheme.primaryContainer,
              ),
            ),
            const SizedBox(height: 24),

            // App name with style
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

            // Developer info
            Center(
              child: Text(
                'Desarrollado por Manuela Duarte',
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface.withAlpha(3),
                ),
              ),
            ),
            const SizedBox(height: 6),

            // Contact
            Center(
              child: Text(
                'Contacto: manueladuartetoro04@gmail.com',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withAlpha(3),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Description card with some elevation and padding
            Card(
              color: colorScheme.primaryContainer.withAlpha(1),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'PomArt es una app para ayudarte a gestionar tu tiempo y creatividad, '
                  'usando técnicas Pomodoro combinadas con temas artísticos diarios y seguimiento visual '
                  'de tus sesiones para mantenerte motivado.',
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurface,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),

            const Spacer(),

            // Button to feedback
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
          ],
        ),
      ),
    );
  }
}
