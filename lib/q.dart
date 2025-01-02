import 'package:advbasics/qscreen.dart';
import 'package:flutter/material.dart';
import 'gcontainer.dart';

class Questions extends StatefulWidget{
  const Questions({super.key});
  
  @override
  State<Questions> createState() {
    return _QuestionsState();
  }
}
class _QuestionsState extends State<Questions>{
  Widget? activeScreen;
  @override
  void initState() {
    activeScreen = StyledText(switchScreen);
    super.initState();
  }

  void switchScreen(){
    setState(() {
      activeScreen= const Qscreen();
    });
  }

  @override
  Widget build(BuildContext context) {
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
        child: activeScreen,
      ),
    ),
  );
  }
}