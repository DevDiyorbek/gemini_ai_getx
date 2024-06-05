import 'dart:math';

import 'package:flutter/material.dart';

import '../pages/home_page.dart';

Widget chatWithGeminiButton(BuildContext context) {
  return ShaderMask(
    shaderCallback: (bounds) =>
        const LinearGradient(colors: [Colors.blue, Colors.red])
            .createShader(bounds),
    child: OutlinedButton(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 15)),
      ),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      },
      child: const Text(
        "Chat with Gemini",
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    ),
  );
}
