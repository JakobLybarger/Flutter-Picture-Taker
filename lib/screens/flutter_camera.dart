import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

import './picture_screen.dart';

class FlutterCamera extends StatefulWidget {
  final CameraDescription camera;

  FlutterCamera({@required this.camera});

  @override
  _FlutterCameraState createState() => _FlutterCameraState();
}

class _FlutterCameraState extends State<FlutterCamera> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("FlutterCamera"),
          centerTitle: true,
        ),
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.camera_alt),
            onPressed: () async {
              try {
                await _initializeControllerFuture;
                final path = join((await getTemporaryDirectory()).path,
                    '${DateTime.now()}.png');
                await _controller.takePicture(path);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PictureScreen(imagePath: path),
                  ),
                );
              } catch (e) {
                print(e);
              }
            }));
  }
}
