import 'package:flutter/material.dart';



///Shows an AlertDialog with the options "Cancel" and "Continue".
///
/// Does nothing on "Cancel" and does whatever is passed to [foo] on "Continue".
Future<dynamic> showAlertDialog(BuildContext context, Function foo, String title, String msg) async {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  () {
      Navigator.of(context).pop();
      },
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed:  () {
      foo();
      Navigator.of(context).pop();
      },
  );

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
    },
  );
}