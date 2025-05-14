import 'package:flutter/material.dart';
import 'package:pomart/widgets/custom_calendar.dart'; 

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key, required this.title});

  final String title;

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> with SingleTickerProviderStateMixin {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: const Color.fromARGB(255, 209, 141, 218),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Día'),
              Tab(text: 'Mes'),
              Tab(text: 'Año'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                CustomCalendar(
                  focusedDay: _focusedDay,
                  selectedDay: _selectedDay,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                ),
                const SizedBox(height: 20),
                if (_selectedDay != null)
                  Text(
                    'Día seleccionado: ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}',
                    style: const TextStyle(fontSize: 18),
                  ),
              ],
            ),
            const Center(child: Text('Vista del mes', style: TextStyle(fontSize: 18))),
            const Center(child: Text('Vista del año', style: TextStyle(fontSize: 18))),
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
      ),
    );
  }
}
