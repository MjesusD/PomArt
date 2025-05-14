import 'package:flutter/material.dart';
import 'package:pomart/entity/user_session.dart';

class SessionTimeline extends StatelessWidget {
  final List<UserSession> sessions;

  const SessionTimeline({super.key, required this.sessions});

  @override
  Widget build(BuildContext context) {
    if (sessions.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'No hay sesiones registradas en este día.',
          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: sessions.length,
        itemBuilder: (context, index) {
          final session = sessions[index];
          return ListTile(
            leading: const Icon(Icons.access_time),
            title: Text("Inicio: ${session.start}"),
            subtitle: Text("Fin: ${session.end}"),
            trailing: const Icon(Icons.arrow_forward),
          );
        },
      ),
    );
  }
}
