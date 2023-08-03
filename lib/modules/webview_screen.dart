

import 'package:flutter/material.dart';
import 'package:mazraaty/shared/components.dart';

import 'package:webview_flutter/webview_flutter.dart';

import '../shared/constants.dart';

class WebViewScreen extends StatefulWidget {
  final String? url;
  final bool? navigate;

  const WebViewScreen({Key? key, this.url,this.navigate = true}) : super(key: key);
  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, title: ""),
      body: WebView(
        initialUrl: Uri.encodeFull(widget.url!),
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}