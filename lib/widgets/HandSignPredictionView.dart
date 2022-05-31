import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:handsfree/main.dart';

class HandSignPredictionView extends StatefulWidget {
  final String title;
  final Function(InputImage inputImage) onImage;
  final CameraLensDirection initialDirection;
  final double width;
  final double height;

  const HandSignPredictionView(
      {Key? key,
      required this.title,
      required this.onImage,
      required this.initialDirection,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  State<HandSignPredictionView> createState() => _HandSignPredictionViewState();
}

class _HandSignPredictionViewState extends State<HandSignPredictionView> {
  late CameraController _controller;
  late CameraDescription camera;
  String predictedLabel = '';

  @override
  initState() {
    super.initState();
    for (int i = 0; i < camerasAvailable.length; i++) {
      if (camerasAvailable[i].lensDirection == widget.initialDirection)
        camera = camerasAvailable[i];
    }
    _startLiveFeed();
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  Future _startLiveFeed() async {
    _controller =
        CameraController(camera, ResolutionPreset.medium, enableAudio: false);
    _controller.initialize().then((value) {
      if (!mounted) return;
      _controller.startImageStream(_processCameraImage);
      setState(() {});
    });
  }

  Future _processCameraImage(CameraImage cameraImage) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in cameraImage.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());

    final InputImageRotation imageRotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.rotation0deg;

    final InputImageFormat inputImageFormat =
        InputImageFormatValue.fromRawValue(cameraImage.format.raw) ??
            InputImageFormat.nv21;

    final planeData = cameraImage.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
    widget.onImage(inputImage);
  }

  Future _stopLiveFeed() async {
    await _controller.stopImageStream();
    await _controller.dispose();
  }

  Widget _liveFeedBody() {
    if (_controller.value.isInitialized == false) {
      return Container();
    }

    return Container(
      color: Colors.black,
      height: widget.height,
      width: widget.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CameraPreview(_controller),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _liveFeedBody();
  }
}
