import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handsfree/widgets/breaker.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';

import '../main.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? controller; // access different functionality
  VideoPlayerController? videoController;
  File? _imageFile;
  bool _isCameraInitialized = false;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _currentScale = 1.0;
  double _baseScale = 1.0;
  double _minAvailableExposureOffSet = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _currentExposureOffset = 0.0;
  bool _isRearCameraSelected = true;
  FlashMode? _currentFlashMode;
  int _pointers = 0;

  List<File> allFileList = [];

  /*
    initialize a new camera controller while overiting the previou one 
  */
  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    // instantiation of the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    //dispose previous camera controller
    await previousCameraController?.dispose();

    // replace with a new controller
    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    // update ui when camera controller changes
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    // initialize the camera controller
    try {
      await cameraController.initialize();
      cameraController.getMaxZoomLevel().then((val) => _maxAvailableZoom = val);
      cameraController.getMinZoomLevel().then((val) => _minAvailableZoom = val);
      cameraController
          .getMinExposureOffset()
          .then((val) => _minAvailableExposureOffSet = val);
      cameraController
          .getMaxExposureOffset()
          .then((val) => _maxAvailableExposureOffset = val);
      _currentFlashMode = controller!.value.flashMode;
    } on CameraException catch (e) {
      print("error initializing camera: $e");
    }

    // update the boolean value of _isCameraInitialized
    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  /*
  As camera is a memory hungry task, we have to keep track of the activity of the app
  in order to free up spaces when idle
   */
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // free up memory when camera is notactive
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // reinitialize the camera with the same properties
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    onNewCameraSelected(camerasAvailable[
        _isRearCameraSelected ? 0 : 1]); // make back camera as default
    refreshAlreadyCapturedImages();
    super.initState();
  }

  @override
  void dispose() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: SystemUiOverlay.values);
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String chatRoomId =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isCameraInitialized
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 1 / controller!.value.aspectRatio,
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      _cameraPreviewWidget(),
                      flashDropDown(),
                      exposureWidget(),
                      actionBar(chatRoomId),
                    ],
                  ),
                ),
              ],
            )
          : Container(),
    );
  }

  Widget flashDropDown() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: DropdownButton<FlashMode>(
          iconSize: 0,
          dropdownColor: Colors.black87,
          underline: Container(),
          value: _currentFlashMode,
          items: [
            DropdownMenuItem<FlashMode>(
              child: Row(children: [
                const Icon(Icons.flash_auto, color: Colors.white),
                Breaker(i: 8, pos: PadPos.right),
                Text(FlashMode.auto.name.toUpperCase(),
                    style: const TextStyle(color: Colors.white)),
              ]),
              value: FlashMode.auto,
            ),
            DropdownMenuItem<FlashMode>(
              child: Row(children: [
                const Icon(Icons.flash_auto, color: Colors.white),
                Breaker(i: 8, pos: PadPos.right),
                Text(FlashMode.off.name.toUpperCase(),
                    style: const TextStyle(color: Colors.white)),
              ]),
              value: FlashMode.off,
            ),
            DropdownMenuItem<FlashMode>(
              child: Row(children: [
                const Icon(Icons.flash_on, color: Colors.white),
                Breaker(i: 8, pos: PadPos.right),
                Text(FlashMode.always.name.toUpperCase(),
                    style: const TextStyle(color: Colors.white)),
              ]),
              value: FlashMode.always,
            ),
            DropdownMenuItem<FlashMode>(
              child: Row(children: [
                const Icon(Icons.flashlight_on_rounded, color: Colors.white),
                Breaker(i: 8, pos: PadPos.right),
                Text(FlashMode.torch.name.toUpperCase(),
                    style: const TextStyle(color: Colors.white)),
              ]),
              value: FlashMode.torch,
            ),
          ],
          onChanged: (val) async {
            setState(() {
              _currentFlashMode = val;
            });
            controller!.setFlashMode(val!);
          }),
    );
  }

  Widget _cameraPreviewWidget() {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return Listener(
        onPointerDown: (_) => _pointers++,
        onPointerUp: (_) => _pointers--,
        child: CameraPreview(
          controller!,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onScaleStart: _handleScaleStart,
              onScaleUpdate: _handleScaleUpdate,
              onTapDown: (TapDownDetails details) =>
                  onViewFinderTap(details, constraints),
            );
          }),
        ),
      );
    }
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (controller == null || _pointers != 2) {
      return;
    }

    _currentScale = (_baseScale * details.scale)
        .clamp(_minAvailableZoom, _maxAvailableZoom);
    setState(() {
      _currentScale = _currentScale;
    });
    await controller!.setZoomLevel(_currentScale);
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }

    final CameraController cameraController = controller!;

    final Offset offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }

  Widget exposureWidget() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _currentExposureOffset.toStringAsFixed(1) + 'x',
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: SizedBox(
              width: 500,
              height: 50,
              child: Slider(
                  activeColor: Colors.white,
                  inactiveColor: Colors.white30,
                  value: _currentExposureOffset,
                  max: _maxAvailableExposureOffset,
                  min: _minAvailableExposureOffSet,
                  onChanged: (val) async {
                    setState(() {
                      _currentExposureOffset = val;
                    });
                    await controller!.setExposureOffset(_currentExposureOffset);
                  }),
            ),
          )
        ]);
  }

  Widget actionBar(String chatRoomId) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          toggleCamera(),
          takePictureButton(chatRoomId),
          GestureDetector(
            onTap: () async {
              XFile? pickedFile = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );
              if (pickedFile != null) {
                File imageFile = File(pickedFile.path);
                int currentUnix = DateTime.now().millisecondsSinceEpoch;
                final directory = await getApplicationDocumentsDirectory();
                String fileFormat = imageFile.path.split('.').last;

                await imageFile.copy(
                  '${directory.path}/$currentUnix.$fileFormat',
                );

                Navigator.pushNamed(context, "/prepsend", arguments: <String>[
                  '${directory.path}/$currentUnix.$fileFormat',
                  chatRoomId
                ]);
              }
            },
            child: lastCapturedWidget(),
          ),
        ],
      ),
    );
  }

  Widget toggleCamera() {
    return InkWell(
      onTap: () {
        setState(() {
          _isCameraInitialized = false;
        });
        onNewCameraSelected(
          camerasAvailable[_isRearCameraSelected ? 0 : 1],
        );
        setState(() {
          _isRearCameraSelected = !_isRearCameraSelected;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(
            Icons.circle,
            color: Colors.white24,
            size: 60,
          ),
          Icon(
            _isRearCameraSelected ? Icons.camera_front : Icons.camera_rear,
            color: Colors.white,
            size: 30,
          ),
        ],
      ),
    );
  }

  Widget takePictureButton(String chatRoomId) {
    return InkWell(
      onTap: () async {
        XFile? rawImage = await takePicture();
        File imageFile = File(rawImage!.path);

        int currentUnix = DateTime.now().millisecondsSinceEpoch;
        final directory = await getApplicationDocumentsDirectory();
        String fileFormat = imageFile.path.split('.').last;

        await imageFile.copy(
          '${directory.path}/$currentUnix.$fileFormat',
        );

        Navigator.pushNamed(context, "/prepsend", arguments: <String>[
          '${directory.path}/$currentUnix.$fileFormat',
          chatRoomId
        ]);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.circle, color: Colors.white38, size: 80),
          Icon(Icons.circle, color: Colors.white, size: 65),
        ],
      ),
    );
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }
    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      print('Error occured while taking picture: $e');
      return null;
    }
  }

  Widget lastCapturedWidget() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.white, width: 2),
        image: _imageFile != null
            ? DecorationImage(
                image: FileImage(_imageFile!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: videoController != null && videoController!.value.isInitialized
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: AspectRatio(
                aspectRatio: videoController!.value.aspectRatio,
                child: VideoPlayer(videoController!),
              ),
            )
          : Container(),
    );
  }

  refreshAlreadyCapturedImages() async {
    final directory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> fileList = await directory.list().toList();
    allFileList.clear();
    List<Map<int, dynamic>> fileNames = [];

    fileList.forEach((file) {
      if (file.path.contains('.jpg') || file.path.contains('.mp4')) {
        allFileList.add(File(file.path));

        String name = file.path.split('/').last.split('.').first;
        fileNames.add({0: int.parse(name), 1: file.path.split('/').last});
      }
    });

    if (fileNames.isNotEmpty) {
      final recentFile =
          fileNames.reduce((curr, next) => curr[0] > next[0] ? curr : next);
      String recentFileName = recentFile[1];

      _imageFile = File('${directory.path}/$recentFileName');

      setState(() {});
    }
  }
}
