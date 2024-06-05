import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../widgets/chat_with_gemini_button.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController =
    VideoPlayerController.asset("assets/videos/flash_video.mp4")
      ..initialize().then((_) {
        setState(() {});
      });

    videoPlayerController.play();
    videoPlayerController.setLooping(true);
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
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
                  child: videoPlayerController.value.isInitialized
                      ? VideoPlayer(videoPlayerController)
                      : Container()),
              chatWithGeminiButton(context)
            ],
          ),
        ),
      ),
    );
  }
}
