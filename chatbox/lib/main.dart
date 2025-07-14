import 'package:chatbox/Splash_Screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatBox',
      theme: ThemeData(fontFamily: 'Helvetica'),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}