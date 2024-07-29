import 'package:flutter/material.dart';
import 'package:gemini_ai_prototype/core/config/root_binding.dart';
import 'package:gemini_ai_prototype/presentation/pages/home_page.dart';
import 'package:gemini_ai_prototype/presentation/pages/start_page.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        'home_page' : (context) => const HomePage()
      },
      home: const StartPage(),
      initialBinding: RootBinding(),
    );
  }
}
