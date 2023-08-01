import 'package:flutter/material.dart';

import 'newsapi/futrure.dart';

void main() {
  runApp( News());
}

class News extends StatelessWidget {
    News({super.key});
  //final StateWdState appdraw = StateWdState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: Theme(data: data, child: child),
      home: SafeArea(
          child: Scaffold(//drawer: appdraw.appDrawer(),
        backgroundColor: Colors.grey[100],
         
        body: StateWd(),
      )),
    );
  }
}
