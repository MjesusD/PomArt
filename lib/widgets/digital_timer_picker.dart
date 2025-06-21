import 'package:flutter/material.dart';

class DigitalTimerPicker extends StatelessWidget {
  final int initialSeconds;
  final Color color;
  final ValueChanged<int> onTimeChanged;

  const DigitalTimerPicker({
    super.key,
    required this.initialSeconds,
    required this.color,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final int minutes = initialSeconds ~/ 60;
    final int seconds = initialSeconds % 60;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _TimeSelector(
          label: 'Min',
          initial: minutes,
          max: 59,
          color: color,
          onChanged: (min) => onTimeChanged(min * 60 + seconds),
        ),
        const SizedBox(width: 16),
        _TimeSelector(
          label: 'Sec',
          initial: seconds,
          max: 59,
          color: color,
          onChanged: (sec) => onTimeChanged(minutes * 60 + sec),
        ),
      ],
    );
  }
}

class _TimeSelector extends StatelessWidget {
  final String label;
  final int initial;
  final int max;
  final Color color;
  final ValueChanged<int> onChanged;

  const _TimeSelector({
    required this.label,
    required this.initial,
    required this.max,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: color)),
        DropdownButton<int>(
          value: initial,
          items: List.generate(
            max + 1,
            (index) => DropdownMenuItem(value: index, child: Text('$index')),
          ),
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
        ),
      ],
    );
  }
}
