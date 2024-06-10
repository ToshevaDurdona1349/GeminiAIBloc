// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// import '../bloc/home_bloc/home_bloc.dart';
//
// class WebViewPage extends StatelessWidget {
//
//   final String url;
//
//   const WebViewPage({required this.url, Key? key}) : super(key: key);
//   late HomeBloc homeBloc;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Web View'),
//       ),
//       body: WebView(
//         initialUrl: url,
//         javascriptMode: JavascriptMode.unrestricted,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../bloc/home_bloc/home_bloc.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  const WebViewPage({required this.url, Key? key}) : super(key: key);


  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late HomeBloc homeBloc;
  late final String url;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web View'),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
