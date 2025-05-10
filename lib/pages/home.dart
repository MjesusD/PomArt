import 'package:flutter/material.dart';
import 'package:pomart/pages/timer.dart';
import 'package:pomart/pages/profile.dart';
import 'package:pomart/pages/content.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Index 0: Home', style: optionStyle),
    Text('Index 1: Profile', style: optionStyle),
    Text('Index 2: Timer', style: optionStyle),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
      body: Center(child: _widgetOptions[_selectedIndex]),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Profile'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
               // _onItemTapped(1);
               Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage(title: 'Perfil',)),
                );
              },
            ),
            ListTile(
              title: const Text('Timer'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                //_onItemTapped(2);
                Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TimerPage(title: 'Timer',)),
                        );
                // Then close the drawer
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Content'),
              selected: _selectedIndex == 3,
              onTap: () {
                // Update the state of the app
                //_onItemTapped(2);
                Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ContentPage(title: 'Content',)),
                        );
                // Then close the drawer
                //Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}