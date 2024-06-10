import 'package:bloc/bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:meta/meta.dart';
import 'package:video_player/video_player.dart';
part 'starter_event.dart';
part 'starter_state.dart';

class StarterBloc extends Bloc<StarterEvent, StarterState> {
  StarterBloc() : super(StarterInitial()) {
  }
  late VideoPlayerController videoPlayerController;
  FlutterTts flutterTts = FlutterTts();

  initVideoPlayer() {
    videoPlayerController = VideoPlayerController.asset("assets/videos/gemini_video.mp4")
      ..initialize().then((_) {
        add(VideoPlayerInitializedEvent());
      });

    videoPlayerController.play();
    videoPlayerController.setLooping(true);
  }

  stopVideoPlayer() {
    videoPlayerController.dispose();
  }

  Future speakTTS(String text) async {
    var result = await flutterTts.speak(text);
    // if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future stopTTS() async {
    var result = await flutterTts.stop();
    // if (result == 1) setState(() => ttsState = TtsState.stopped);
  }
}
