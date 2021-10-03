import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:flutter_speed_dial/flutter_speed_dial.dart' as flutter_speed_dial;
import 'package:scanner/image_loader.dart' as image_loader;
import 'package:scanner/preview_screen.dart' as preview_screen;
import 'package:scanner/scan_history.dart' as scan_history;

class ScannerHomeScreen extends StatefulWidget {
  const ScannerHomeScreen({Key? key}) : super(key: key);

  @override
  _ScannerHomeScreenState createState() => _ScannerHomeScreenState();
}

class _ScannerHomeScreenState extends State<ScannerHomeScreen> {
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
      body: scan_history.ScanHistory(),
      floatingActionButton: flutter_speed_dial.SpeedDial(
          icon: Icons.add,
          backgroundColor: Colors.teal,
          children: [
            flutter_speed_dial.SpeedDialChild(
              child: Icon(Icons.camera_alt_outlined),
              label: 'Camera',
              backgroundColor: Colors.teal,
              onTap: () {
                load_and_preview(image_picker.ImageSource.camera);},
            ),
            flutter_speed_dial.SpeedDialChild(
              child: Icon(Icons.picture_in_picture_outlined),
              label: 'Gallery',
              backgroundColor: Colors.teal,
              onTap: () {
                load_and_preview(image_picker.ImageSource.gallery);},
            ),
          ]
      ),
    );
  }

  /// Loads image from [imageSource] and previews it in new tab.
  Future<void> load_and_preview(image_picker.ImageSource imagesource) async {
    File image = await image_loader.loadImageFromSource(imagesource);
    if (image.path != "") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => preview_screen.PreviewScreen(image)))
          .then((_) => setState(() {}));
    }
  }
}
