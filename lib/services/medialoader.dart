import 'dart:io';
import 'package:path/path.dart';
import 'package:handsfree/api/firebase_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MediaLoader {
  MediaLoader();

  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }

  Future<Widget> getImage(
      BuildContext context, String imageName, BoxFit fit) async {
    return await loadImage(context, imageName)
        .then((imageUrl) => Image.network(imageUrl.toString(), fit: fit));
  }
}
