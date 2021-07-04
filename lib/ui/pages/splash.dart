import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text("Banao Notes"),

      ),
    );
  }

  delay() async{
    Duration( seconds: 3);
  }
}