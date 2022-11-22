import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cat or Dog",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Cat Or Dog")
        ),
        body: const Center(
          child: Text("Dog or Cat"),
        ),
      ),
    );
  }
}

