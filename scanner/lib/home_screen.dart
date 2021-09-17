import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scanner/image_loader.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:scanner/preview_screen.dart';
import 'package:scanner/scan_history.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Image> images = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to the Scanner App"),
        backgroundColor: Colors.teal,
      ),
      body: ScanHistory(),
      floatingActionButton: SpeedDial(
          icon: Icons.add,
          backgroundColor: Colors.teal,
          children: [
            SpeedDialChild(
              child: Icon(Icons.camera_alt_outlined),
              label: 'Camera',
              backgroundColor: Colors.teal,
              onTap: () {
                load_and_preview(ImageSource.camera);},
            ),
            SpeedDialChild(
              child: Icon(Icons.picture_in_picture_outlined),
              label: 'Gallery',
              backgroundColor: Colors.teal,
              onTap: () {
                load_and_preview(ImageSource.gallery);},
            ),
          ]
      ),
    );
  }

  Future<void> load_and_preview(ImageSource imagesource) async {
    File image = await loadImageFromSource(imagesource);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PreviewScreen(image)),
    );
  }
}
