import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NewsWeb extends StatefulWidget {
  final String url;
  final String title;

  NewsWeb({required this.url, required this.title});

  @override
  _NewsWebState createState() => _NewsWebState();
}

class _NewsWebState extends State<NewsWeb> {
  double _progress = 0;
  InAppWebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(child: Icon(Icons.arrow_back),tooltip:'Go Back' ,
          onPressed: () {
            return Navigator.pop(context);
          },
        ),
        extendBodyBehindAppBar: false,
        
        body: Stack(
          children: [
            InAppWebView(
              onLoadError: (controller, url, code, message) {
                Text('ERROR');
              },
              initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  useOnDownloadStart: true,
                ),
              ),
              onProgressChanged: (controller, progress) {
                setState(() {
                  _progress = progress / 100;
                });
              },
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
            ),
            if (_progress < 0.4)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
