import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;

  const AppDrawer({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorScheme.primaryContainer,
                  colorScheme.secondaryContainer,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/logo2.png'),
                ),
                const SizedBox(width: 16),
                Text(
                  'POMART',
                  style: textTheme.headlineSmall?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(context, Icons.home, 'Pantalla de inicio', '/home'),
          _buildDrawerItem(context, Icons.person, 'Perfil', '/profile'),
          _buildDrawerItem(context, Icons.timer, 'Temporizador', '/timer'),
          _buildDrawerItem(context, Icons.calendar_today, 'Calendario', '/calendar'),
          _buildDrawerItem(context, Icons.timeline, 'Línea Cronológica', '/cronoline'),
          _buildDrawerItem(context, Icons.settings, 'Preferencias', '/preferences'),
          _buildDrawerItem(context, Icons.info_outline, 'Acerca de', '/about'),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, IconData icon, String title, String routeName) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      onTap: () {
        Navigator.pop(context); // Cierra el drawer primero
        if (currentRoute != routeName) {
          Navigator.pushReplacementNamed(context, routeName);
        }
      },
    );
  }
}
