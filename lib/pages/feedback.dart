import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';
import 'package:pomart/entity/question.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  List<Question> questions = [];
  Map<int, dynamic> answers = {};
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final jsonStr = await rootBundle.loadString('lib/data/models/questions.json');
    final List<dynamic> jsonList = jsonDecode(jsonStr);

    setState(() {
      questions = jsonList.map((e) => Question.fromJson(e)).toList();
    });
  }

  Widget _buildQuestionField(Question question) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Widget styledContainer(Widget child) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: child,
      );
    }

    final questionText = Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        question.question,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
      ),
    );

    switch (question.type) {
      case 'rating':
        return styledContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              questionText,
              DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colorScheme.surface,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                dropdownColor: colorScheme.surface,
                items: List.generate(5, (i) => i + 1)
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text('$value', style: theme.textTheme.bodyLarge),
                        ))
                    .toList(),
                value: answers[question.id],
                validator: (val) => val == null ? 'Selecciona una opción' : null,
                onChanged: (val) => setState(() => answers[question.id] = val),
              ),
            ],
          ),
        );

      case 'text':
        return styledContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              questionText,
              TextFormField(
                maxLines: 4,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Por favor escribe una respuesta' : null,
                onSaved: (val) => answers[question.id] = val,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colorScheme.surface,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        );

      case 'yesno':
        return styledContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              questionText,
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colorScheme.surface,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                dropdownColor: colorScheme.surface,
                items: ['Sí', 'No']
                    .map((opt) => DropdownMenuItem(
                          value: opt,
                          child: Text(opt, style: theme.textTheme.bodyLarge),
                        ))
                    .toList(),
                value: answers[question.id],
                validator: (val) => val == null ? 'Selecciona una opción' : null,
                onChanged: (val) => setState(() => answers[question.id] = val),
              ),
            ],
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Future<void> _sendFeedback() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    if (_userIdController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingresa tu identificación')),
      );
      return;
    }

    final body = StringBuffer();
    body.writeln('Usuario: ${_userIdController.text.trim()}');
    body.writeln('Opiniones:');
    for (var q in questions) {
      final answer = answers[q.id] ?? 'Sin respuesta';
      body.writeln('${q.question}: $answer');
    }

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'manueladuartetoro04@gmail.com',
      queryParameters: {
        'subject': 'Opinión PomArt',
        'body': body.toString(),
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el cliente de correo')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Valorar / Dar opinión'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: questions.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _userIdController,
                      decoration: InputDecoration(
                        labelText: 'Tu identificación (nombre, email, etc.)',
                        prefixIcon: Icon(Icons.person, color: colorScheme.primary),
                        filled: true,
                        fillColor: colorScheme.surfaceContainerHighest,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      style: theme.textTheme.bodyLarge,
                      validator: (val) => val == null || val.trim().isEmpty
                          ? 'Por favor ingresa tu identificación'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    ...questions.map(_buildQuestionField),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _sendFeedback,
                      icon: const Icon(Icons.send),
                      label: const Text('Enviar opinión'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
