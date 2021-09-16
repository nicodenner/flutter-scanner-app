import 'dart:io';
import 'package:flutter/material.dart';

class PreviewScreen extends StatefulWidget {
  final File image;
  const PreviewScreen(this.image);

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Preview"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                widget.image.path == "" ? Container() : Expanded(
                  child: Image.file(
                    File(widget.image.path),
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ]
          )
      ),
    );
  }

  Future<File> getImage() async{
    File img = await widget.image;
    return img;
  }
}
