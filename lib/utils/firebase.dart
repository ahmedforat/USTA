import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class FirebaseDemo extends StatefulWidget {
  @override
  _FirebaseDemoState createState() => _FirebaseDemoState();
}

class _FirebaseDemoState extends State<FirebaseDemo> {
  bool isThereImage = false;
  File pickedImage;
  var recognizedText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello firebase"),
      ),
      body:Column(
        children: <Widget>[
          Container(
            width: 100,
            height: 50,
            color: Colors.red,
            child: Text('Hello'),
          )
        ],
      ),
    );
  }
}
