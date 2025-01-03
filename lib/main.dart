import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'q.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Firebase Initialization Error: $e');
  }
  runApp(const Questions());
}
