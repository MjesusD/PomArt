import 'package:flutter/material.dart';

class TimerDisplay extends StatelessWidget {
  final int remainingSeconds;
  final Color color;

  const TimerDisplay({
    super.key,
    required this.remainingSeconds,
    required this.color,
  });

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.hourglass_bottom,
          size: 50,
          color: color,
        ),
        const SizedBox(height: 20),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade200,
            border: Border.all(
              color: color,
              width: 4,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            _formatTime(remainingSeconds),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
