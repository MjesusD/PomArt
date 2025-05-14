import 'package:flutter/material.dart';

class PomodoroControls extends StatelessWidget {
  final bool isRunning;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onReset;

  const PomodoroControls({
    super.key,
    required this.isRunning,
    required this.onStart,
    required this.onPause,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: isRunning ? null : onStart,
          icon: const Icon(Icons.play_arrow),
          label: const Text("Iniciar"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 177, 248, 180),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton.icon(
          onPressed: isRunning ? onPause : null,
          icon: const Icon(Icons.pause),
          label: const Text("Pausar"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 236, 214, 179),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton.icon(
          onPressed: onReset,
          icon: const Icon(Icons.refresh),
          label: const Text("Reiniciar"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 245, 172, 190),
          ),
        ),
      ],
    );
  }
}
