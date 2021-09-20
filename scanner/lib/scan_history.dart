import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scanner/preview_screen.dart' as preview_screen;
import 'package:scanner/text_form_dialog.dart' as text_form_dialog;
import 'image_loader.dart' as image_loader;

/// Widget listing all the scans of the user.
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
    reLoadImages();
  }

  @override
  Widget build(BuildContext context) {
    reLoadImages();
    return FutureBuilder(
        future: reLoadImages(),
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

  /// Creates a new list element.
  ///
  /// It contains a mini preview and details about [file].
  /// It allows the user to modify [file] e.g. deleting, renaming...
  Widget createListElement(File file) {
    String filename = file.path.split('/').last;
    return ListTile(
      leading: Image.file(
        file,
        alignment: Alignment.center,
      ),
      title: Text(filename),
      trailing: _imageOptions(file),
      onTap: () {Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => preview_screen.PreviewScreen(file)))
          .then((_) => setState(() {}));},
      contentPadding: EdgeInsets.all(8.0),
    );
  }

  /// Reloads all images from the current working directory.
  Future<void> reLoadImages() async {
    scans = await image_loader.loadAllImagesFromDirectory();
  }

  /// Widget containg the [file] modification options.
  Widget _imageOptions(File file) {
    return PopupMenuButton(
      onSelected: (value) async {
        if (value == "preview") {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => preview_screen.PreviewScreen(file)))
              .then((_) => setState(() {}));
        }
        if (value == "delete") {
          image_loader.deleteImage(file.path);
        }
        if (value == "rename") {
          await text_form_dialog.showTextDialog(context);
          String newName = text_form_dialog.getUserInput();
          image_loader.renameImage(file.path, newName);
        }
        setState(
                () {reLoadImages();}
        );
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          child: Text("Preview"),
          value: "preview",
        ),
        const PopupMenuItem(
          child: Text("Rename"),
          value: "rename",
        ),
        const PopupMenuItem(
          child: Text("Delete"),
          value: "delete",
        ),
      ]
    );
  }
}
