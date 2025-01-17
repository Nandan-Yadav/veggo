import 'package:flutter/material.dart';
import 'package:veggo/widgets/custom_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: CustomImage(imagePath: 'assets/images/welcome_text.svg')));
  }
}
