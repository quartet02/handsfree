import 'dart:io';
import 'package:path/path.dart';
import 'package:handsfree/api/firebase_api.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// uncomment amd copy to use
// theory of using media from firebase is placing the URL into Image.network() method of Image class
// we can specify filename to firebase and ask firebase to give us the URL download link of the image we store

// this is a code of taking the URL of media from firebase, and returning a dynamic image type

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<String> loadImage(String image) async {
    return await FirebaseStorage.instance
        .ref()
        .child(image)
        .getDownloadURL()
        .onError((error, stackTrace) => image);
  }
}

// display image widget
// fetch and download the image from firebase storage
Future<Widget> getImage(String imageName) async {
  late Image image;
  await FireStorageService.loadImage(imageName).then((value) {
    image = Image.network(
      value.toString(),
      fit: BoxFit.scaleDown,

      // Do more modification of image here
    );
  });
  return image;
}

// method to upload a file from mobile and save it to firebase
Future<String> uploadFile(File file, String dbPath, String chatRoomId) async {
  if (file == null) return "";

  final fileName = basename(file.path);
  final destination = '$dbPath/$chatRoomId/$fileName';

  UploadTask? task = FirebaseApi.uploadFile(destination, file);

  if (task == null) return "";

  final snapshot = await task.whenComplete(() {});
  final urlDownload = await snapshot.ref.getDownloadURL();

  return urlDownload;
  // to display the url
}

Future<String> uploadFileByPath(
    String filePath, String dbPath, String chatRoomId) async {
  File? file = File(filePath);
  if (file == null) return "";

  final fileName = basename(file.path);
  final destination = '$dbPath/$chatRoomId/$fileName';

  UploadTask? task = FirebaseApi.uploadFile(destination, file);

  if (task == null) return "";

  final snapshot = await task.whenComplete(() {});
  final urlDownload = await snapshot.ref.getDownloadURL();

  return urlDownload;
}
// File (picture, video, audio selector structure)
/*
child: FutureBuilder(
  // imageName = name of image in Firebase Storage
  future: _getImage(context, imageName),
  builder: (context, snapshot) {
    if(snapshot.connectionState == ConnectionState.done){
      return Container(
        width: MediaQuery.of(context).size.width/ 1.2,
        height: MediaQuery.of(context).size.width/ 1.2,
        child: snapshot.data,
      );
    }
    if (snapshot.connectionState == ConnectionState.waiting){
      return Container(
      width: MediaQuery.of(context).size.width/ 1.2,
      height: MediaQuery.of(context).size.width/ 1.2,
      child: CircularProgressIndicator(),
      );
    }

    return Container();
  }), //FutureBuilder
*/

// Choosing picture from mobile
// media selector expand here
/*
// // Button for select file and upload file
// ButtonWidget(
//   text: 'Select File',
//   icon: Icons.attach_file,
//   onClicked: selectFile,
// ),
// SizedBox(height: 8),
// Text(
//   fileName,
//   style: TextStyle(fontSize: 16),
// ),
// SizedBox(height: 48),
// ButtonWidget(
//   text: 'Upload File',
//   icon: Icons.cloud_upload_outlined,
//   onClicked: uploadFile,
// ),
*/

// basic structure of file select and upload page, expand to get reference
// 2 important variable and 2 important function include in here
/*
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // uploaded task return the link of the media to be displayed from firebase
  UploadTask? task;

  // file return the file path of the media in firebase
  File? file;

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                text: 'Select File',
                icon: Icons.attach_file,
                onClicked: selectFile,
              ),
              SizedBox(height: 8),
              Text(
                fileName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 48),
              ButtonWidget(
                text: 'Upload File',
                icon: Icons.cloud_upload_outlined,
                onClicked: uploadFile,
              ),
              SizedBox(height: 20),
              task != null ? buildUploadStatus(task!) : Container(),
            ],
          ),
        ),
      ),
    );
  }

// method to select a file from mobile and save it as a path
Future selectFile() async {
  final result = await FilePicker.platform.pickFiles(allowMultiple: false);

  if (result == null) return;
  final path = result.files.single.path;

  setState(() => file = File(path!));
}
*/




// percentage counter for upload
/*
Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
  stream: task.snapshotEvents,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      final snap = snapshot.data!;
      final progress = snap.bytesTransferred / snap.totalBytes;
      final percentage = (progress * 100).toStringAsFixed(2);

      return Text(
        '$percentage %',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
    } else {
      return Container();
    }
  },
);
*/
