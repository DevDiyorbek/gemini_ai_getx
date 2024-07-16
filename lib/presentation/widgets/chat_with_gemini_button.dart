import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gemini_ai_prototype/presentation/pages/SecondPage.dart';
import 'package:gemini_ai_prototype/presentation/pages/start_page.dart';
import 'package:page_transition/page_transition.dart';

import '../pages/home_page.dart';

Widget chatWithGeminiButton(BuildContext context) {
  return ShaderMask(
    shaderCallback: (bounds) =>
        const LinearGradient(colors: [Colors.blue, Colors.red])
            .createShader(bounds),
    child: OutlinedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          PageTransition(
              alignment: Alignment.bottomCenter,
              curve: Curves.easeInOut,
              duration: const Duration(seconds: 2),
              reverseDuration: const Duration(milliseconds: 600),
              type: PageTransitionType.rightToLeftJoined,
              child: const HomePage(),
              childCurrent: const StartPage()),
        );
      },
      child: const Text(
        "Chat with Gemini",
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    ),
  );
}

