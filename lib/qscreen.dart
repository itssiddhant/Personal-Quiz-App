import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:advbasics/data/questions.dart';

class Qscreen extends StatefulWidget {
  const Qscreen({super.key,required this.onSelectAnswer});
  final void Function(String answer) onSelectAnswer;

  @override
  State<StatefulWidget> createState() {
    return _QscreenState();
  }
}

class AnswerButton extends StatelessWidget {
  const AnswerButton({super.key, required this.answer, required this.onTap});
  final String answer;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 142, 4, 255),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder()),
        child: Text(answer,textAlign: TextAlign.center,
        ));
  }
}

class _QscreenState extends State<Qscreen> {
  var currIndex = 0;

  void answerQuestion(String i) {
    widget.onSelectAnswer(i);
    setState(() {
      currIndex++;
    });
  }

  @override
  Widget build(context) {
    final currQuestion = questions[currIndex];
    return Center(
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(currQuestion.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontStyle: FontStyle.italic)),
            const SizedBox(height: 30),
            ...currQuestion.getShuffled().map(
              (e) {
                return AnswerButton(answer: e, onTap: (){
                  answerQuestion(e);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
