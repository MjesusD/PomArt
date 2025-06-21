import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomart/entity/session_entry.dart';

class CronolinePage extends StatefulWidget {
  const CronolinePage({super.key, required this.title});
  final String title;

  @override
  State<CronolinePage> createState() => _CronolinePageState();
}

class _CronolinePageState extends State<CronolinePage> {
  List<SessionEntry> _sessions = [];

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList('session_entries') ?? [];

    final loaded = stored
        .map((e) => SessionEntry.fromJson(jsonDecode(e)))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    if (!mounted) return;
    setState(() {
      _sessions = loaded;
    });
  }

  Widget _buildTimeline() {
    return ListView.builder(
      itemCount: _sessions.length,
      itemBuilder: (context, index) {
        final session = _sessions[index];
        final formattedDate =
            "${session.date.day}/${session.date.month}/${session.date.year}";

        return ListTile(
          leading: const Icon(Icons.circle, color: Colors.deepPurple),
          title: Text(formattedDate, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('Minutos: ${session.minutes} | Tema: ${session.theme}'),
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Detalle de la sesión'),
                content: Text(
                  'Fecha: $formattedDate\nMinutos usados: ${session.minutes}\nTema: ${session.theme}',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cerrar'),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color.fromARGB(255, 209, 141, 218),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Línea cronológica de sesiones de temporizador',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(child: _buildTimeline()),
        ],
      ),
    );
  }
}
