import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class StartController extends GetxController {
  late VideoPlayerController videoPlayerController;

  initVideoPlayer() {
    videoPlayerController =
        VideoPlayerController.asset("assets/videos/flash_video.mp4")
          ..initialize().then((_) {
            update();
          });

    videoPlayerController.play();
    videoPlayerController.setLooping(true);
  }

  stopVideoPlayer(){
    videoPlayerController.dispose();
  }
}
