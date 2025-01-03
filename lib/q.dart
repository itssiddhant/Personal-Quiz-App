import 'package:advbasics/data/questions.dart';
import 'package:advbasics/qscreen.dart';
import 'package:advbasics/rscreen.dart';
import 'package:flutter/material.dart';
import 'gcontainer.dart';

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  State<Questions> createState() {
    return _QuestionsState();
  }
}

class _QuestionsState extends State<Questions> {
  List<String> selectedAnswers = [];
  var activeScreen = 'screen1';

  void switchScreen() {
    setState(() {
      activeScreen = 'screen2';
    });
  }

  void inputAnswer(String answer){
    selectedAnswers.add(answer);
    if(selectedAnswers.length==questions.length){
      setState(() {
        selectedAnswers=[];
        activeScreen = 'result';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StyledText(switchScreen);
    if(activeScreen=='screen1'){
      screenWidget=Qscreen(onSelectAnswer: inputAnswer);
    }
    if(activeScreen=='result'){
      screenWidget= ResultScreen(chosenAnswers: selectedAnswers);
    }
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
