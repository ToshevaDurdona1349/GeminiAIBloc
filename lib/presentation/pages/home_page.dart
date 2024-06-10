import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shake/shake.dart';
import '../bloc/home_bloc/home_bloc.dart';
import '../bloc/home_bloc/home_state.dart';
import '../widgets/item_gemini_message.dart';
import '../widgets/item_user_mesage.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc homeBloc;


  @override
  void initState() {
    super.initState();
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.loadHistoryMessages();
    homeBloc.initSTT();


    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Shake!'),
          ),
        );
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
  }



  @override
  void dispose() {
    homeBloc.textController.dispose();
    homeBloc.textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<HomeBloc,HomeState>(
          builder: (context, state) {
            return Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 20, top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 45,
                        child: Image(
                          image: AssetImage('assets/images/gemini_logo.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(15),
                          child: homeBloc.messages.isEmpty
                              ? Center(
                            child: SizedBox(
                              width: 70,
                              child: Image.asset(
                                  'assets/images/gemini_icon.png'),
                            ),
                          )
                              : ListView.builder(
                            itemCount: homeBloc.messages.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var message = homeBloc.messages[index];
                              if (message.isMine!) {
                                return itemOfUserMessage(message);
                              } else {
                                return itemOfGeminiMessage(message);
                              }
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20, left: 20),
                        padding: const EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.grey, width: 1.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            homeBloc.pickedImage != null
                                ? Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 16),
                                  height: 100,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.memory(
                                      base64Decode(
                                          homeBloc.pickedImage!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 16),
                                  padding:
                                  const EdgeInsets.only(top: 5, right: 5),
                                  height: 100,
                                  width: 100,
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        child: const Icon(Icons.cancel),
                                        onTap: () {
                                          homeBloc.onRemovedImage();
                                        },
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                                : const SizedBox.shrink(),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: homeBloc.textController,
                                    focusNode: homeBloc.textFieldFocusNode,
                                    maxLines: null,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Message',
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                // Add some space between TextField and Icons
                                // if (homeController.textController.text
                                //     .isEmpty) // Show icons only if text is empty
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    homeBloc.onSelectedImage();
                                  },
                                  icon: const Icon(
                                    Icons.attach_file,
                                    color: Colors.grey,
                                  ),
                                ),
                                // if (homeController.textController.text
                                //     .isEmpty) // Show icons only if text is empty
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    homeBloc.speechToText.isNotListening
                                        ? homeBloc.startSTT()
                                        : homeBloc.stopSTT();
                                  },
                                  icon: const Icon(
                                    Icons.mic,
                                    color: Colors.grey,
                                  ),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    var text = homeBloc.textController.text
                                        .toString()
                                        .trim();
                                    homeBloc.onSendPressed(text);
                                  },
                                  icon: const Icon(
                                    Icons.send,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                homeBloc.isLoading ? Center(
                  child: Container(
                    height: 70,
                    child: Lottie.asset('assets/animations/gemini_loading.json'),
                  ),
                ) : SizedBox.shrink()
              ],
            );
          },
        ),
      ),
    );
  }
}