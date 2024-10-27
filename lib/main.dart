import 'package:flutter/material.dart';
import 'package:veggo/screens/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF388E3C)),
        useMaterial3: true,
      ),
      home: const OnBoardingScreen(),
    );
  }
}