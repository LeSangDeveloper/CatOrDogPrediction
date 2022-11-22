import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Cat Dog Identifier")
      ),
      body: Center(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  border: Border.all(color: Colors.white),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(2, 2),
                      spreadRadius: 2,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: (_imageFile != null) ? Image.file(_imageFile!) : Image.network('https://i.imgur.com/sUFH1Aq.png')
            ),
            ElevatedButton(
                onPressed: selectImg,
                child: const Icon(Icons.camera)
            ),
          ],
        ),
      ),
    );
  }

  Future selectImg() async {
    var picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery, maxHeight: 300);
    setState(() {
      if (image != null) {
        _imageFile = File(image.path);
      } else {
        debugPrint("No image is selected!");
      }
    });
  }

}


