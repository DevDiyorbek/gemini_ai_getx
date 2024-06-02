import 'package:flutter/material.dart';
import 'package:gemini_ai_prototype/data/repositories/gemini_talk_repository_impl.dart';
import 'package:gemini_ai_prototype/domain/usecases/text_and_image_use_case.dart';
import 'package:gemini_ai_prototype/domain/usecases/text_only_use_case.dart';
import '../../core/services/log_service.dart';
import '../../core/services/utils_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextOnlyUseCase textOnlyUseCase = TextOnlyUseCase(GeminiTalkRepositoryImpl());
  TextAndImageUseCase textAndImageUseCase =
      TextAndImageUseCase(GeminiTalkRepositoryImpl());

  apiTextOnly() async {
    var text = "What is the best way to learn Flutter development?";
    var result = await textOnlyUseCase.call(text);
    LogService.i(result.toString());
  }

  apiTextAndImage() async {
    var text = "What is this image?";
    var base64Image = await Utils.pickAndConvertImage();
    LogService.i(base64Image);

    var result =  await textAndImageUseCase.call(text, base64Image);
    LogService.i(result.toString());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Gemini"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                apiTextOnly();
              },
              child: const Text("Text Only Input"),
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                apiTextAndImage();
              },
              child: const Text("Text And Image Input"),
            ),
          ],
        ),
      ),
    );
  }
}
