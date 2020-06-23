import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatelessWidget {
  MyWebView({
    @required this.title,
    @required this.selectedUrl,
  });

  final String selectedUrl;
  final String title;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  Widget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        selectedUrl,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      centerTitle: true,
      leading: new IconButton(
        icon: new Icon(
          Icons.arrow_back,
        ),
        color: Colors.white,
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(
            Mdi.share,
          ),
          color: Colors.white,
          onPressed: () {
            Share.share(
              '$selectedUrl Hey, check this out !',
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: WebView(
        initialUrl: selectedUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
