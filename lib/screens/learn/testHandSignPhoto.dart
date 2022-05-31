import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handsfree/provider/lessonCardProvider.dart';
import 'package:handsfree/services/predictImage.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class TestHandSignPhoto extends StatefulWidget {
  final String title;
  const TestHandSignPhoto({Key? key, required this.title}) : super(key: key);

  @override
  State<TestHandSignPhoto> createState() => _TestHandSignPhotoState();
}

class _TestHandSignPhotoState extends State<TestHandSignPhoto> {
  File? imageFile;
  XFile? pickedFile;

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

  @override
  Widget build(BuildContext context) {
    LessonCardProvider provider = Provider.of<LessonCardProvider>(context);

    return Column(
      children: [
        imageFile == null ? Container():
        Container(
          child: Image.file(
            imageFile!,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: GestureDetector(
              onTap: () async {
                _getFromCamera();
                Map<String, dynamic> results = await PredictImage.classifyImage(pickedFile!, false);
                debugPrint("Hand Sign in quiz: ");
                debugPrint(results.toString());
                List<String> labels = results["labels"];
                if (labels.contains(widget.title)) {
                  provider.setQuesInput = widget.title;
                } else {
                  provider.setQuesInput = "null";
                }
              },
              child: Stack(children: <Widget>[
                Center(
                  child: Container(
                      alignment: Alignment.center,
                      width: 200,
                      decoration:
                      const BoxDecoration(
                          borderRadius:
                          BorderRadius
                              .all(Radius
                              .circular(
                              20)),
                          boxShadow: [
                            BoxShadow(
                              color:
                              kButtonShadow,
                              offset:
                              Offset(6, 6),
                              blurRadius: 6,
                            ),
                          ]),
                      child: Image.asset(
                        'assets/image/purple_button.png',
                        scale: 4,
                      )),
                ),
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                      top: 10),
                  child: Text(
                    'Take Photo',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kTextLight,
                    ),
                  ),
                ),
              ])),
        )

      ],
    );

  }

  /// Get from camera
  _getFromCamera() async {
    pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile!.path);
      });
    }
  }
}
