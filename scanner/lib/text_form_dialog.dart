import 'package:flutter/material.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _textEditingController = TextEditingController();
String userInput = "";

/// Shows a dialog which accepts a text input from the user.
///
/// It is not allowed to enter an empty string.
Future<dynamic> showTextDialog(BuildContext context) async {
  return showDialog(
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
                    return (value != "") ? null : "Empty Field";
                  },
                  decoration: const InputDecoration(hintText: "Enter New Name"),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Save"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  userInput = _textEditingController.text;
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        );
      });
}

/// Returns input of user.
String getUserInput() => userInput;