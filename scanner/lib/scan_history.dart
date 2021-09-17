import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scanner/preview_screen.dart';

import 'image_loader.dart';

class ScanHistory extends StatefulWidget {
  const ScanHistory({Key? key}) : super(key: key);

  @override
  _ScanHistoryState createState() => _ScanHistoryState();
}

class _ScanHistoryState extends State<ScanHistory> {
  List<File> scans = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: load(),
        builder: (BuildContext context,
            AsyncSnapshot snapshot) {
          return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (BuildContext context, int index) {
              return createListElement(scans[index]);
            },
          );
        },

    );
  }

  Widget createListElement(File file) {
    String filename = file.path.split('/').last;
    return ListTile(
      /// Change Image.asset() to Image.file()
      leading: Image.file(
        file,
        alignment: Alignment.center,
      ),
      title: Text(filename),
      trailing:  IconButton(
          icon: Icon(Icons.more_horiz),
          onPressed: () {print("Hello");},
      ),
      onTap: () {Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PreviewScreen(file)));},
      contentPadding: EdgeInsets.all(8.0),
    );
  }

  Future<void> load() async{
    scans = await loadAllImagesFromDirectory();
  }
}
