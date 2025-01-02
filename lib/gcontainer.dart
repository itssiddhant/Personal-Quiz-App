import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  const StyledText(this.nextScreen,{super.key});
  
  final void Function() nextScreen;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/Untitled.png',
            width: 310,
          ),
          const Text('Ready for the Quiz?',style: TextStyle(fontSize: 26, color: Colors.white)),
          const SizedBox(height: 30),
          OutlinedButton.icon(
            icon: const Icon(Icons.arrow_circle_right_outlined),
            onPressed: nextScreen,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white
            ),
            label: const Text(
              'Start!',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
