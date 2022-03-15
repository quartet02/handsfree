import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

typedef StreamStateCallback = void Function(MediaStream stream);

class Signaling {
  Map<String, dynamic> configuration = {
    'iceServers': [
      {
        'urls': [
          'stun:stun1.l.google.com:19302',
          'stun:stun2.l.google.com:19302'
        ]
      }
    ]
  };

  Signaling();

  RTCPeerConnection? peerConnection;
  MediaStream? localStream;
  MediaStream? remoteStream;
  String? roomId;
  String? currentRoomText;
  StreamStateCallback? onAddRemoteStream;
  List<Map> _localIceCandidates = [];
  List<Map> _remoteIceCandidates = [];
  final _filename = 'file.txt';
  final uid = "uid2";

  Future<String> createRoom(RTCVideoRenderer remoteRenderer) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference roomRef =
        db.collection('chatRoom').doc("66kavpkCFcSYFcdVp7mh");

    // var file = await File(_filename).writeAsString(
    //     'Create PeerConnection with configuration: $configuration\n');

    peerConnection = await createPeerConnection(
        configuration); // allow connection to other peers

    registerPeerConnectionListeners();

    localStream?.getTracks().forEach((track) {
      peerConnection?.addTrack(track, localStream!);
    });

    // Code for collecting ICE candidates below
    var i = 0;
    peerConnection?.onIceCandidate = (RTCIceCandidate candidate) async {
      // var file = await File(_filename)
      //     .writeAsString('Got candidate: ${candidate.toMap()}\n');
      _localIceCandidates.add(candidate.toMap());
    };
    roomRef.set({
      uid: {
        "icelist": FieldValue.arrayUnion(_localIceCandidates),
      }
    }, SetOptions(merge: true));

    // create an offer when creating a roomId
    RTCSessionDescription offer = await peerConnection!.createOffer();
    await peerConnection!.setLocalDescription(offer);

    Map<String, dynamic> roomWithOffer = {
      'offer': offer.toMap(),
    };

    await roomRef.set({uid: roomWithOffer}, SetOptions(merge: true)); // set sdp
    var roomId = roomRef.id;

    // listen to remote session description
    roomRef.snapshots().listen((snapshot) async {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (peerConnection?.getRemoteDescription() != null &&
          data["uid2"]["offer"].isNotEmpty) {
        var answer = RTCSessionDescription(
          data["uid2"]["offer"]["sdp"],
          data["uid2"]["offer"]["type"],
        );

        await peerConnection?.setRemoteDescription(answer);
      }
    });

    // listen for remote sdp changes and add to ICE candidate list
    //  roomRef.snapshots().listen((snapshot) {
    //   snapshot.docChanges.forEach((change) {
    //     if (change.type == DocumentChangeType.added) {
    //       Map<String, dynamic> data = change.doc.data() as Map<String, dynamic>;
    //       print('Got new remote ICE candidate: ${jsonEncode(data)}');
    //       peerConnection!.addCandidate(
    //         RTCIceCandidate(
    //           data['candidate'],
    //           data['sdpMid'],
    //           data['sdpMLineIndex'],
    //         ),
    //       );
    //     }
    //   });
    // });
    return roomId;
  }

  Future<void> openUserMedia(
      RTCVideoRenderer callerVideo, RTCVideoRenderer receipientVideo) async {
    // if caller video stream is setup before
    if (callerVideo.srcObject != null) {
      print("hi");
      callerVideo.srcObject!
          .getVideoTracks()
          .forEach((track) => {track.enabled = true});
    } else {
      var configuration = {
        'video': true,
        'audio': true,
      };

      var stream = await navigator.mediaDevices.getUserMedia(configuration);

      callerVideo.srcObject = stream; // setup caller video stream
      localStream = stream;

      receipientVideo.srcObject = await createLocalMediaStream('key');
    }
  }

  Future<void> closeCamera(RTCVideoRenderer callerVideo) async {
    callerVideo.srcObject!
        .getVideoTracks()
        .forEach((track) => {track.enabled = false});
  }

  Future<void> registerPeerConnectionListeners() async {
    peerConnection?.onIceGatheringState = (RTCIceGatheringState state) async {
      var file = await File(_filename)
          .writeAsString('ICE gathering state changed: $state\n');
    };

    peerConnection?.onConnectionState = (RTCPeerConnectionState state) async {
      var file = await File(_filename)
          .writeAsString('Connection state change: $state\n');
    };

    peerConnection?.onSignalingState = (RTCSignalingState state) async {
      var file = await File(_filename)
          .writeAsString('Signaling state change: $state\n');
    };

    peerConnection?.onIceGatheringState = (RTCIceGatheringState state) async {
      var file = await File(_filename)
          .writeAsString('ICE connection state changed: $state\n');
    };

    peerConnection?.onAddStream = (MediaStream stream) async {
      var file = await File(_filename).writeAsString("Add remote stream\n");
      onAddRemoteStream?.call(stream);
      remoteStream = stream;
    };
  }
}
