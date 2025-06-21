import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class TimerDisplay extends StatelessWidget {
  final int remainingSeconds;
  final Color color;
  final bool isRunning;
  final void Function(int minutes)? onTimeChanged; 

  const TimerDisplay({
    super.key,
    required this.remainingSeconds,
    required this.color,
    required this.isRunning,
    this.onTimeChanged,
  });

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  @override
  Widget build(BuildContext context) {
    if (isRunning) {
      // Muestra sólo el tiempo restante durante la cuenta regresiva
      return Column(
        children: [
          Icon(Icons.timer, size: 50, color: color),
          const SizedBox(height: 20),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
              border: Border.all(color: color, width: 4),
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
    } else {
      // Si no está corriendo, muestra el slider para seleccionar tiempo
      return Column(
        children: [
          const SizedBox(height: 10),
          SleekCircularSlider(
            initialValue: remainingSeconds / 60.0,
            min: 5,
            max: 60,
            appearance: CircularSliderAppearance(
              size: 180,
              customWidths: CustomSliderWidths(
                trackWidth: 6,
                progressBarWidth: 10,
                handlerSize: 10,
              ),
              customColors: CustomSliderColors(
                trackColor: Colors.grey[300]!,
                progressBarColor: color,
                dotColor: color,
              ),
              infoProperties: InfoProperties(
                mainLabelStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                modifier: (double value) {
                  return '${value.floor()} min';
                },
              ),
            ),
            onChange: (double value) {
              if (onTimeChanged != null) {
                onTimeChanged!(value.floor()); // pasa minutos
              }
            },
          ),
        ],
      );
    }
  }
}
