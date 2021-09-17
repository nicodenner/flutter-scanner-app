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
    MaterialPageRoute(builder: (context) => PreviewScreen(file)));},
      contentPadding: EdgeInsets.all(8.0),
    );
  }

  Future<void> reLoadImages() async {
    scans = await loadAllImagesFromDirectory();
  }

  Widget _imageOptions(File file) {
    return PopupMenuButton(
      onSelected: (value) async {
        if (value == "preview") {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PreviewScreen(file)));
        }
        if (value == "delete") {
          deleteImage(file.path);
        }
        if (value == "rename") {
          await showTextDialog(context);
          String newName = _textEditingController.text;
          renameImage(file.path, newName);
        }
        setState(
                () {reLoadImages();}
        );
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text("Preview"),
          value: "preview",
        ),
        PopupMenuItem(
          child: Text("Rename"),
          value: "rename",
        ),
        PopupMenuItem(
          child: Text("Delete"),
          value: "delete",
        ),
      ]
    );
  }
}


///TextFormDialog
GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController _textEditingController = TextEditingController();
String userInput = "";

Future<void> showTextDialog(BuildContext context) async{
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _textEditingController,
                  validator: (value) {
                    return (value != "") ? null: "Empty Field";
                  },
                  decoration: InputDecoration(
                      hintText: "Enter New Name"
                  ),
                )],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:Text("Save"),
              onPressed: () {
                if(_formKey.currentState!.validate()) {
                  userInput = _textEditingController.text;
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        );
      });
}