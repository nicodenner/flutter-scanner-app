import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart'
    as flutter_speed_dial;
import 'package:scanner/img_processing.dart' as Img_PP;

class PreviewScreen extends StatefulWidget {
  File image;

  PreviewScreen(this.image);

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
            widget.image.path == ""
                ? Container()
                : Expanded(
                    child: Image.file(
                      File(widget.image.path),
                      filterQuality: FilterQuality.high,
                    ),
                  ),
          ])),
      floatingActionButton: flutter_speed_dial.SpeedDial(
          icon: Icons.edit,
          backgroundColor: Colors.teal,
          children: [
            // Possible icons Icons.settings_display_rounded
            flutter_speed_dial.SpeedDialChild(
              child: Icon(Icons.brush),
              label: 'blue_threshold',
              backgroundColor: Colors.blueAccent,
              onTap: () {
                Future getImage() async {
                  var image =
                      await Img_PP.ImgProcessor().aug_black(widget.image);

                  setState(() {
                    widget.image = image;
                  });
                }
                getImage();
              },
            ),
            flutter_speed_dial.SpeedDialChild(
              child: Icon(Icons.brush),
              label: 'red_threshold',
              backgroundColor: Colors.red,
              onTap: () {
                // call post processing method
              },
            ),
            flutter_speed_dial.SpeedDialChild(
              child: Icon(Icons.brush),
              label: 'greed_threshold',
              backgroundColor: Colors.green,
              onTap: () {
                // call post processing method
              },
            ),
          ]),
    );
  }
}
