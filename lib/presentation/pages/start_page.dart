import 'package:flutter/material.dart';
import 'package:gemini_ai_prototype/presentation/controllers/start_controller.dart';
import 'package:gemini_ai_prototype/presentation/widgets/google_sign_in_button.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final startController = Get.find<StartController>();

  @override
  void initState() {
    super.initState();
    startController.initVideoPlayer();
  }

  @override
  void dispose() {
    startController.stopVideoPlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 80),
          child: Column(
            children: [
              const Image(
                image: AssetImage("assets/images/gemini_logo.png"),
                height: 40,
              ),
              Expanded(
                  child: startController.videoPlayerController.value.isInitialized
                      ? VideoPlayer(startController.videoPlayerController)
                      : Container()),
              googleSignUp(context)
              // chatWithGeminiButton(context)
            ],
          ),
        ),
      ),
    );
  }
}
