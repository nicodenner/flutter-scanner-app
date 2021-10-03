import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart'
    as flutter_speed_dial;
import 'package:scanner/alert_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image/image.dart' as Img;
import 'package:scanner/image_loader.dart' as Img_Loader;
import 'package:scanner/img_processing.dart' as Img_PP;

class PreviewScreen extends StatefulWidget {
  File source;    // source file holds possibility to fall back to original image.
  Img.Image? currentImgData;    // Don't mix up with Image Widget from material.dart

  PreviewScreen(this.source, {Key? key}) : super(key: key) {
    if (source.path != "") {
      currentImgData = Img.decodeImage(source.readAsBytesSync());
    }
    //displayImg = Image.file(source, filterQuality: FilterQuality.high);
  }

  Image imgWidgetFromData() {
    List<int> data = Img.encodeJpg(currentImgData!);    //adds Jpg header to bitmap
    return Image.memory(data as Uint8List, filterQuality: FilterQuality.high);
  }

  Future<void> safeCurrentImg(BuildContext context) async{
    Directory localDir = await Img_Loader.directory;
    // build new filename and append "_Edit" to original name
    String filename = source.path.split('/').last;
    List<String> splitName = filename.split('.');
    splitName[0] = splitName[0] + '_Edit';
    filename = splitName.join(".");
    String safePath = localDir.path + '/' + filename;

    if (await File(safePath).exists()) {
      await showAlertDialog(context, (){
        File(safePath).writeAsBytesSync(Img.encodeJpg(currentImgData!));
      }, "Attention!",
          "An edited version of this file already exist. "
              "If you continue the existing file will be replaced.");
    }
    else {
      File(safePath).writeAsBytesSync(Img.encodeJpg(currentImgData!));
    }
  }

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  bool edited = false; // Used to detect if file has been edited.
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.source.path.split('/').last),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: (){Share.share("Komm in die Gruppe!");},
          ),
          edited == false     // if picture is not edited the safe button doesn't exist
              ? Container()
              : IconButton(
                  icon: Icon(
                    Icons.save_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () async{
                    await widget.safeCurrentImg(context);
                    Navigator.pop(context);
                  },
                )
        ],
        backgroundColor: Colors.teal,
      ),
      body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("Last modified: " + widget.source.lastModifiedSync().toString().split(".").first),
                Text("File size: " + (widget.source.lengthSync() / 1048576).toStringAsFixed(3).toString() + " MB"),
                widget.source.path == ""
                    ? Container()
                    : Expanded(child: widget.imgWidgetFromData()),
          ])),
      floatingActionButton: flutter_speed_dial
          .SpeedDial(icon: Icons.edit, backgroundColor: Colors.teal, children: [
        // Possible icons Icons.settings_display_rounded
        flutter_speed_dial.SpeedDialChild(
          child: Icon(Icons.brush),
          label: 'blue_threshold',
          backgroundColor: Colors.blueAccent,
          onTap: () {
            widget.currentImgData =
                Img_PP.fAugColor(widget.currentImgData!, Img_PP.AugColor.blue);
            edited = true;
            setState(() {});
          },
        ),
        flutter_speed_dial.SpeedDialChild(
          child: Icon(Icons.brush),
          label: 'red_threshold',
          backgroundColor: Colors.red,
          onTap: () {
            //widget.currentImgData = Img_PP.fAugRed(widget.currentImgData!);
            widget.currentImgData =
                Img_PP.fAugColor(widget.currentImgData!, Img_PP.AugColor.red);
            edited = true;
            setState(() {});
            //Img_PP.ImgProcessor().augRed(widget.source);
          },
        ),
        flutter_speed_dial.SpeedDialChild(
          child: Icon(Icons.brush),
          label: 'green_threshold',
          backgroundColor: Colors.green,
          onTap: () {
            widget.currentImgData =
                Img_PP.fAugColor(widget.currentImgData!, Img_PP.AugColor.green);
            edited = true;
            setState(() {});
          },
        ),
        flutter_speed_dial.SpeedDialChild(
          child: Icon(Icons.brush),
          label: 'white_threshold',
          backgroundColor: Colors.white,
          onTap: () {
            widget.currentImgData =
                Img_PP.fAugColor(widget.currentImgData!, Img_PP.AugColor.white);
            edited = true;
            setState(() {});
          },
        ),
        flutter_speed_dial.SpeedDialChild(
          child: Icon(Icons.brush),
          label: 'black_threshold',
          backgroundColor: Colors.black,
          onTap: () {
            widget.currentImgData =
                Img_PP.fAugColor(widget.currentImgData!, Img_PP.AugColor.black);
            edited = true;
            setState(() {});
          },
        ),
      ]),
    );
  }
}
