// COVID-19 Map Tracker
// Tyler Hatzenbuhler
// Data from Johns Hopkins University

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID Webview',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'COVID-19 Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String pagelink =
      "https://www.arcgis.com/apps/opsdashboard/index.html#/85320e2ea5424dfaaa75ae62e5c06e61";

  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.blueGrey[900],
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: () {
              if (_controller.isCompleted) {
                _controller.future.then((result) {
                  result.reload();
                });
              }
            }),
            IconButton(icon: Icon(Icons.home), onPressed: () {
              if (_controller.isCompleted) {
                _controller.future.then((result) {
                  result.loadUrl(pagelink);
                });
              }
            })
          ],
        ),
        body: WebView(
          initialUrl: pagelink,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
}
