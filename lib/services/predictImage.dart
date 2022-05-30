import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class PredictImage {
  static late ImageLabeler _imageLabeler;
  static bool _canProcess = false;
  static List<String> _predictedLabels =[];
  static List<int> _predictedIndexes =[];
  static List<double> _predictedConfidences =[];

  PredictImage() {
    if (_canProcess == false) _initializeDetector('assets/tflite/model.tflite', 3, 0.4);
  }

  static void clearData() {
    _predictedLabels.clear();
    _predictedConfidences.clear();
    _predictedIndexes.clear();
  }

  static Future classifyImage(XFile pickedFile, bool oneOutput) async {
    // oneOutput set to true to get label with the highest confidence

    InputImage inputImage = InputImage.fromFilePath(pickedFile.path);

    if (_canProcess == false) _initializeDetector('assets/tflite/model.tflite', 3, 0.4);
    clearData();

    final List<ImageLabel> labels =
        await _imageLabeler.processImage(inputImage);

    // return top 1 label only
    if (oneOutput) return labels.isEmpty ? null :labels[0].label;

    debugPrint("predictions: ");

    for (ImageLabel label in labels) {
      _predictedIndexes.add(label.index);
      _predictedConfidences.add(label.confidence);
      _predictedLabels.add(label.label);
      debugPrint(label.label);
      debugPrint(label.confidence.toString());
    }

    return {
      "index": _predictedIndexes,
      "confidence": _predictedConfidences,
      "label": _predictedLabels,
    };
  }

  static void _initializeDetector(String modelPath, int maxCount, double confidenceThreshold) async {
    modelPath = await _getModel(modelPath);
    final options = LocalLabelerOptions(
        modelPath: modelPath, maxCount: maxCount, confidenceThreshold: confidenceThreshold);
    _imageLabeler = ImageLabeler(options: options);
    _canProcess = true;
  }

  static Future<String> _getModel(String assetPath) async {
    if (Platform.isAndroid) {
      return 'flutter_assets/$assetPath';
    }
    final path = '${(await getApplicationSupportDirectory()).path}/$assetPath';
    await Directory(dirname(path)).create(recursive: true);
    final file = File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(assetPath);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }

  static void dispose(){
    _imageLabeler.close();
  }
}
