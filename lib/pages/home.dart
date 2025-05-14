import 'package:flutter/material.dart';
import 'package:pomart/pages/timer.dart';
import 'package:pomart/pages/profile.dart';
import 'package:pomart/pages/calendar.dart';
import 'package:pomart/pages/cronoline.dart';
import 'package:pomart/widgets/feed_view.dart'; 

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
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
      body: const FeedView(), 
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 212, 173, 235),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/logo2.png'),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'POMART',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: 'Pomart Home'),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(title: 'Profile'),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Timer'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TimerPage(title: 'Timer'),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Calendar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CalendarPage(title: 'Calendar'),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Cronoline'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CronolinePage(title: 'Cronoline'),
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
