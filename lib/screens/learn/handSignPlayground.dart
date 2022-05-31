import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:handsfree/services/predictImage.dart';
import 'package:handsfree/widgets/HandSignPredictionView.dart';

import '../../widgets/constants.dart';

class HandSignPlayground extends StatefulWidget {
  final double width = 0;
  final double height = 0;
  // const HandSignPlayground({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<HandSignPlayground> createState() => _HandSignPlaygroundState();
}

class _HandSignPlaygroundState extends State<HandSignPlayground> {
  bool _isBusy = false;
  List<String> labels = [];
  List<int> indexes = [];
  List<double> confidences = [];
  String output = '';

  @override
  void initState() {
    PredictImage();
    super.initState();
  }

  @override
  void dispose() {
    PredictImage.dispose();
    super.dispose();
  }

  Future<void> processImage(InputImage inputImage) async {
    if (_isBusy) return;
    _isBusy = true;
    final predictions = await PredictImage.classifyImages(inputImage);
    labels = predictions['label'];
    indexes = predictions['index'];
    confidences = predictions['confidence'];
    _isBusy = false;
    output = '';

    if (mounted) {
      setState(() {
        for (int i = 0; i < labels.length; i++) {
          output += '' + labels[i] + ', ' + confidences[i].toString();
        }
      });
    }

    labels.forEach(debugPrint);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/image/purple_heading.png'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            HandSignPredictionView(
              title: 'Hand Sign Classifier',
              onImage: (inputImage) {
                processImage(inputImage);
              },
              initialDirection: CameraLensDirection.front,
              height: widget.height,
              width: widget.width,
            ),
            Text(
              'Labels: \n' + output,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: kText,
              ),
            )
          ],
        ),
      ),
    );
  }
}
