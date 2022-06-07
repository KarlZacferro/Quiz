import 'package:flutter/material.dart';

import 'models/question.dart';
import 'models/database.dart';
import './widgets/option_button.dart';

void main() {
  runApp(const QuizzApp());
}

class QuizzApp extends StatefulWidget {
  const QuizzApp({Key? key}) : super(key: key);

  @override
  State<QuizzApp> createState() => _QuizzAppState();
}

class _QuizzAppState extends State<QuizzApp> {
  List<Question> _questions = Database.selectRandom(4);
  int _questionIndex = 0;
  int _score = 0;

  void _checkAnswer(bool correct) {
    if (correct) {
      setState(() {
        _score += _questions[_questionIndex].value;
      });
    }

    debugPrint('correto: $correct');
  }

  @override
  Widget build(BuildContext context) {
    final options = List<OptionButton>.generate(
      _questions[_questionIndex].options.length,
      (index) => OptionButton(
        text: _questions[_questionIndex].options[index].text,
        correct: _questions[_questionIndex].options[index].correct,
        onPressed: _checkAnswer,
      ),
    );

    debugPrint(options.toString());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Quizz'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                _questions[_questionIndex].text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...options,
          ],
        ),
      ),
    );
  }
}
