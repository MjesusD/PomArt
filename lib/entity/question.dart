class Question {
  final int id;
  final String question;
  final String type;

  Question({required this.id, required this.question, required this.type});

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json['id'],
    question: json['question'],
    type: json['type'],
  );
}
