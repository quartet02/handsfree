import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:handsfree/services/predictImage.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/HandSignPredictionView.dart';

import '../../widgets/backButton.dart';
import '../../widgets/constants.dart';

class HandSignPlayground extends StatefulWidget {
  const HandSignPlayground({Key? key}) : super(key: key);

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

  double confidence = 0;
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
          output += '' + labels[i];
          confidence = confidences[i];
        }
      });
    }

    labels.forEach(debugPrint);
  }

  Widget breaker(double i) {
    return Padding(
      padding: EdgeInsets.only(bottom: i),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/image/purple_heading.png'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Button.backButton(context, 30, 8),
            Container(
              padding: const EdgeInsets.only(left: 40, bottom: 5, right: 40),
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
              child: Column(
                children: [
                  buildText.bigTitle("Hand Sign\nPlayground"),
                  breaker(MediaQuery.of(context).size.height / 8),
                  buildText.heading3Text('Keep your hand inside the frame.'),
                  breaker(MediaQuery.of(context).size.height / 60),
                  Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: kTextShadow,
                              offset: Offset(10, 10),
                              blurRadius: 20,
                            ),
                          ],
                          image: DecorationImage(
                              alignment: Alignment.topCenter,
                              image: AssetImage(
                                  'assets/image/dictionary_rect.png'),
                              fit: BoxFit.cover),
                        ),
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width / 1.2,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 55),
                        child: Center(
                          child: HandSignPredictionView(
                            title: 'Hand Sign Classifier',
                            onImage: (inputImage) {
                              processImage(inputImage);
                            },
                            initialDirection: CameraLensDirection.back,
                            height: MediaQuery.of(context).size.height / 2.2,
                            width: MediaQuery.of(context).size.width / 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  breaker(MediaQuery.of(context).size.height / 25),
                  buildText.heading2Text('Labels: ' + output),
                  breaker(MediaQuery.of(context).size.height / 80),
                  buildText.heading3Text(confidence > 0.7
                      ? "Please posititon your hand better"
                      : "Keep it up. You have done well."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
