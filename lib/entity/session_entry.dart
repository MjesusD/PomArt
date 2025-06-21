class SessionEntry {
  final DateTime date;
  final int minutes;
  final String theme;

  SessionEntry({
    required this.date,
    required this.minutes,
    required this.theme,
  });

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'minutes': minutes,
        'theme': theme,
      };

  factory SessionEntry.fromJson(Map<String, dynamic> json) => SessionEntry(
        date: DateTime.parse(json['date']),
        minutes: json['minutes'],
        theme: json['theme'],
      );
}
