import 'package:flutter/material.dart';
import 'dart:io';

class PictureScreen extends StatelessWidget {
  final String imagePath;

  PictureScreen({this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Picture'),
      ),
      body: Image.file(File(imagePath)),
    );
  }
}
