import 'package:advbasics/data/questions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuestionSummary extends StatelessWidget {
  const QuestionSummary({super.key, required this.summaryData});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
            children: summaryData.map(
          (e) {
            bool isCorrect = e['correct'] == e['answer'];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCorrect ? Colors.green : Colors.red,
                    ),
                    child: Center(
                      child: Text(
                        ((e['index'] as int) + 1).toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e['questions'] as String),
                        const SizedBox(height: 5),
                        Text(
                          e['answer'] as String,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 202, 171, 252),
                          ),
                        ),
                        Text(
                          e['correct'] as String,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 6, 255, 93),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ).toList(),
      ),
    ));
  }
}

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.chosenAnswers, required this.onRestart});

  final void Function() onRestart;
  final List<String> chosenAnswers;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late List<Map<String, Object>> summaryData;

  @override
  void initState() {
    super.initState();
    summaryData = getSummary();
    saveAllAnswers(summaryData);
  }

  List<Map<String, Object>> getSummary() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < widget.chosenAnswers.length; i++) {
      summary.add(
        {
          'index': i,
          'questions': questions[i].text,
          'correct': questions[i].answers[0],
          'answer': widget.chosenAnswers[i],
        },
      );
    }

    return summary;
  }

  Future<void> saveAllAnswers(List<Map<String, Object>> summaryData) async {
    try {
      final allAnswers = summaryData
          .map((e) => {
                'index': e['index'],
                'question': e['questions'],
                'correct_answer': e['correct'],
                'chosen_answer': e['answer'],
              })
          .toList();

      final firestore = FirebaseFirestore.instance;
      final docRef = firestore.collection('quiz_results').doc(); 

      await docRef.set({
        'user_id': '007',
        'timestamp': FieldValue.serverTimestamp(),
        'all_answers': allAnswers,
      });
    } catch (e) {
      print("Error saving data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalQ = questions.length;
    final corrQ = summaryData.where((element) {
      return element['correct'] == element['answer'];
    }).length;

    return Center(
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You answered $corrQ out of $totalQ questions correctly!'),
            const SizedBox(
              height: 30,
            ),
            QuestionSummary(summaryData: summaryData),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              onPressed: widget.onRestart,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Restart Quiz!'),
            ),
          ],
        ),
      ),
    );
  }
}
