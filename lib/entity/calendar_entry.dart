class CalendarEntry {
  final DateTime date;
  final String imagePath;
  final String title;
  final String description;
  final String theme;


  CalendarEntry({
    required this.date,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.theme,
    
  });

    Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'imagePath': imagePath,
    'title': title,
    'description': description,
    'theme': theme,
   
  };

  factory CalendarEntry.fromJson(Map<String, dynamic> json) => CalendarEntry(
    date: DateTime.parse(json['date']),
    imagePath: json['imagePath'],
    title: json['title'],
    description: json['description'],
    theme: json['theme'],
    
  );
}
