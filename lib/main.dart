import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import './screens/flutter_camera.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(
    MaterialApp(
      home: FlutterCamera(
        camera: firstCamera,
      ),
    ),
  );
}
