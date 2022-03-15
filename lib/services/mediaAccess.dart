import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller; // access different functionality
  bool _isCameraInitialized = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
