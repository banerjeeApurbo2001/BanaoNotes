import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Confirm Delete"),
      content: Text("Are you sure you want to delete?"),
      actions: <Widget>[
        FlatButton(
          child: Text("No"),
          onPressed: () => Navigator.pop(context, false),
        ),
        FlatButton(
          child: Text("Yes"),
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    );
  }
}
