import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class CustomCalendar extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;
  final CalendarBuilders calendarBuilders;


  const CustomCalendar({
  super.key,
  required this.focusedDay,
  required this.selectedDay,
  required this.onDaySelected,
  this.calendarBuilders = const CalendarBuilders(),
});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: focusedDay,
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      onDaySelected: onDaySelected,
      calendarFormat: CalendarFormat.month,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Mes',
      },
      calendarStyle: const CalendarStyle(
        cellMargin: EdgeInsets.all(8),
        todayDecoration: BoxDecoration(
          color: Color.fromARGB(255, 152, 0, 240),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.deepPurple,
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      calendarBuilders: calendarBuilders,
    );
  }
}
