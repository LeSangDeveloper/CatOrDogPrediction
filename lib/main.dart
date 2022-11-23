import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

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
    return MaterialApp(
      home: const MyHomePage(),
      theme: ThemeData(appBarTheme: AppBarTheme(
        backgroundColor: Colors.indigo.shade800,
        foregroundColor: Colors.white
      )),
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
  List? _classifiedResult;

  @override
  void initState() {
    super.initState();
    loadImageModel();
  }

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
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.indigo.shade800;
                      }
                      return Colors.indigo.shade600; // Use the component's default.
                    },
                  ),
                ),
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
    classifyImage(image!);
  }

  Future loadImageModel() async {
    Tflite.close();
    String? result;
    result = await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
    debugPrint(result);
  }

  Future classifyImage(XFile image) async {
    _classifiedResult = null;
    final List? result = await Tflite.runModelOnImage(path: image.path, numResults: 6);
    debugPrint("classification done!!!");
    setState(() {
      if (image != null) {
        _imageFile = File(image.path);
        _classifiedResult = result;
      } else {
        debugPrint('No image selected.');
      }
    });
  }

}


