import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/message_model.dart';
import '../bloc/home_bloc/home_bloc.dart';
import '../bloc/home_bloc/home_event.dart';
import '../bloc/home_bloc/home_state.dart';
import '../pages/webview_page.dart';

Widget itemOfGeminiMessage(MessageModel message) {
  return BlocBuilder<HomeBloc, HomeState>(
    builder: (context, state) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(top: 15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 24,
                  child: Image.asset('assets/images/gemini_icon.png'),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<HomeBloc>().add(SpeakTTSEvent(message.message!));
                  },
                  child: Icon(
                    Icons.volume_up,
                    color: Colors.white70,
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Linkify(
                onOpen: (link) async {
                  // Open the link in a webview
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WebViewPage(url: link.url),
                  ));
                },
                text: message.message!,
                style: TextStyle(
                    color: Color.fromRGBO(173, 173, 176, 1), fontSize: 16),
                linkStyle: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      );
    },
  );
}
