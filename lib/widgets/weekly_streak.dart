import 'package:flutter/material.dart';


class WeeklyStreak extends StatelessWidget {
  final int daysCompleted; // de 0 a 7

  const WeeklyStreak({super.key, required this.daysCompleted});

  @override
  Widget build(BuildContext context) {
    const int maxDays = 7;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(maxDays, (index) {
        final completed = index < daysCompleted;

        return Container(
          key: ValueKey(index), // para mejor identificación en la lista
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: completed ? Colors.green : Colors.grey.shade300,
            shape: BoxShape.circle,
            boxShadow: completed
                ? [
                    BoxShadow(
                      color: Colors.greenAccent.withAlpha(1),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: completed
                ? const Icon(Icons.check, color: Colors.white, size: 18, semanticLabel: 'Día completado')
                : null,
          ),
        );
      }),
    );
  }
}
