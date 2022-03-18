import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  static const String id = 'camera_page';
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text("Camera"),
      ),
    );
  }
}
