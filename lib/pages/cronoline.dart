import 'package:flutter/material.dart';
import 'package:pomart/entity/user_session.dart';
import 'package:pomart/widgets/session_timeline.dart';

class CronolinePage extends StatefulWidget {
  const CronolinePage({super.key, required this.title});
  final String title;

  @override
  State<CronolinePage> createState() => _CronolinePageState();
}

class _CronolinePageState extends State<CronolinePage> {
  DateTime? _selectedDay;

  final Map<DateTime, List<UserSession>> _usageData = {
    DateTime.utc(2024, 5, 10): [
      UserSession(start: "09:00", end: "09:25"),
      UserSession(start: "14:00", end: "14:30"),
    ],
    DateTime.utc(2024, 5, 11): [
      UserSession(start: "12:00", end: "12:45"),
    ],
    DateTime.utc(2024, 5, 12): [
      UserSession(start: "16:00", end: "16:30"),
    ],
  };

  List<UserSession> _getSessionsForDay(DateTime day) {
    return _usageData[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final sessions = _getSessionsForDay(_selectedDay ?? DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color.fromARGB(255, 209, 141, 218),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Línea cronológica de sesiones de uso:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          SessionTimeline(sessions: sessions),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Botón "+" presionado')),
          );
        },
        backgroundColor: const Color.fromARGB(255, 209, 141, 218),
        child: const Icon(Icons.add),
      ),
    );
  }
}
