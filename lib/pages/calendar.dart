import 'dart:convert';
import 'dart:io';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pomart/widgets/custom_calendar.dart';
import 'package:pomart/entity/daily_theme.dart';
import 'package:pomart/entity/calendar_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomart/widgets/drawer.dart';  //nuevo drawer

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

  List<CalendarEntry> _entries = [];
  final DailyTheme _dailyTheme = DailyTheme();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _selectedDay = _focusedDay;
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final String? entriesJson = prefs.getString('calendar_entries');
    if (entriesJson != null) {
      final List<dynamic> decoded = jsonDecode(entriesJson);
      setState(() {
        _entries = decoded.map((e) => CalendarEntry.fromJson(e)).toList();
      });
    }
  }

  Future<void> _saveEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(_entries.map((e) => e.toJson()).toList());
    await prefs.setString('calendar_entries', encoded);
  }

  Future<Map<String, String>?> _showInputDialog() async {
    String tempTitle = '';
    String tempDescription = '';

    return await showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Detalles de la imagen'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Título'),
                onChanged: (val) => tempTitle = val,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Descripción'),
                onChanged: (val) => tempDescription = val,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop({
                  'title': tempTitle,
                  'description': tempDescription,
                });
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final result = await _showInputDialog();
    if (result == null || !mounted) return;

    final theme = _dailyTheme.getThemeToday();

    final newEntry = CalendarEntry(
      date: _selectedDay!,
      imagePath: image.path,
      title: result['title'] ?? '',
      description: result['description'] ?? '',
      theme: theme,
    );

    setState(() {
      _entries.add(newEntry);
    });

    await _saveEntries();

    // Guardar la ruta de la imagen en SharedPreferences para la galería del perfil
    final prefs = await SharedPreferences.getInstance();
    List<String> galleryImages = prefs.getStringList('galleryImages') ?? [];
    if (!galleryImages.contains(image.path)) {
      galleryImages.add(image.path);
      await prefs.setStringList('galleryImages', galleryImages);
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Imagen guardada correctamente')),
    );
  }

  List<CalendarEntry> _getEntriesForDay(DateTime day) {
    return _entries.where((entry) => isSameDay(entry.date, day)).toList();
  }

  List<CalendarEntry> _getEntriesForMonth(DateTime day) {
    return _entries.where((entry) =>
        entry.date.year == day.year && entry.date.month == day.month).toList();
  }

  List<CalendarEntry> _getEntriesForYear(DateTime day) {
    return _entries.where((entry) => entry.date.year == day.year).toList();
  }

  Widget _buildEntryCard(CalendarEntry entry) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Image.file(File(entry.imagePath), width: 50, fit: BoxFit.cover),
        title: Text(entry.title),
        subtitle: Text('${entry.description}\nTema: ${entry.theme}'),
        isThreeLine: true,
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          tooltip: 'Eliminar imagen',
          onPressed: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Confirmar eliminación'),
                content: const Text('¿Quieres eliminar esta imagen? Esta acción no se puede deshacer.'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
                  TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Eliminar')),
                ],
              ),
            );

            if (confirm != true) return;

            setState(() {
              _entries.remove(entry);
            });

            await _saveEntries();

            final prefs = await SharedPreferences.getInstance();
            List<String> galleryImages = prefs.getStringList('galleryImages') ?? [];
            if (galleryImages.contains(entry.imagePath)) {
              galleryImages.remove(entry.imagePath);
              await prefs.setStringList('galleryImages', galleryImages);
            }

            if (!mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Imagen eliminada correctamente')),
            );
          },
        ),
      ),
    );
  }

  Set<DateTime> get _daysWithEntries {
    return _entries.map((e) => DateTime(e.date.year, e.date.month, e.date.day)).toSet();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    List<CalendarEntry> filteredEntries;
    switch (_tabController.index) {
      case 0:
        filteredEntries = _selectedDay != null ? _getEntriesForDay(_selectedDay!) : [];
        break;
      case 1:
        filteredEntries = _getEntriesForMonth(_focusedDay);
        break;
      case 2:
        filteredEntries = _getEntriesForYear(_focusedDay);
        break;
      default:
        filteredEntries = [];
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(color: colorScheme.onPrimary),
          ),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: colorScheme.onPrimary,
            labelColor: colorScheme.onPrimary,
            unselectedLabelColor: colorScheme.onPrimary.withAlpha(60),
            tabs: const [
              Tab(text: 'Día'),
              Tab(text: 'Mes'),
              Tab(text: 'Año'),
            ],
            onTap: (_) => setState(() {}),
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              color: colorScheme.onPrimary,
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        drawer: const AppDrawer(currentRoute: '/calendar'),
        body: TabBarView(
          controller: _tabController,
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
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) {
                      if (_daysWithEntries.contains(DateTime(day.year, day.month, day.day))) {
                        return Positioned(
                          bottom: 1,
                          child: Container(
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              color: colorScheme.secondary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                if (_selectedDay != null)
                  Text(
                    'Día seleccionado: ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}',
                    style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
                  ),
                const Divider(),
                Expanded(
                  child: filteredEntries.isEmpty
                      ? Center(
                          child: Text(
                            'No hay imágenes para esta selección',
                            style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
                          ),
                        )
                      : ListView(children: filteredEntries.map(_buildEntryCard).toList()),
                ),
              ],
            ),
            Center(
              child: filteredEntries.isEmpty
                  ? Text(
                      'No hay imágenes para este mes',
                      style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface, fontSize: 18),
                    )
                  : ListView(children: filteredEntries.map(_buildEntryCard).toList()),
            ),
            Center(
              child: filteredEntries.isEmpty
                  ? Text(
                      'No hay imágenes para este año',
                      style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface, fontSize: 18),
                    )
                  : ListView(children: filteredEntries.map(_buildEntryCard).toList()),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _pickImage,
          backgroundColor: colorScheme.primary,
          child: Icon(Icons.add_a_photo, color: colorScheme.onPrimary),
        ),
      ),
    );
  }
}
