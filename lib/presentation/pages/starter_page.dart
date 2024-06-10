import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';
import '../../core/constants/constants.dart';
import '../bloc/starter_bloc/starter_bloc.dart';
import 'home_page.dart';

class StarterPage extends StatefulWidget {
  const StarterPage({super.key});

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> {
  late StarterBloc starterBloc;

  @override
  void initState() {
    super.initState();

    starterBloc.speakTTS(welcomingMessage);
    starterBloc.initVideoPlayer();
  }

  @override
  void dispose() {
    starterBloc.stopVideoPlayer();
    starterBloc.stopTTS();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<StarterBloc,StarterState>(
        builder: (context,index) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    child: Lottie.asset('assets/animations/gemini_logo.json'),
                  ),
                  Expanded(
                    child: starterBloc
                        .videoPlayerController.value.isInitialized
                        ? VideoPlayer(starterBloc.videoPlayerController)
                        : Container(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, HomePage.id);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Chat with Gemini ',
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 18),
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}