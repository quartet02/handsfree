import 'dart:math';

import 'package:flutter/material.dart';

import 'package:webrtc_interface/webrtc_interface.dart';

import 'package:flutter_webrtc/src/native/rtc_video_renderer_impl.dart';

class CustomRTCVideoView extends StatelessWidget {
  CustomRTCVideoView(
    this._renderer, {
    Key? key,
    this.objectFit = RTCVideoViewObjectFit.RTCVideoViewObjectFitContain,
    this.mirror = false,
    this.filterQuality = FilterQuality.low,
    this.rotate = 0,
  }) : super(key: key);

  final RTCVideoRenderer _renderer;
  final RTCVideoViewObjectFit objectFit;
  final bool mirror;
  final FilterQuality filterQuality;
  final int rotate;

  RTCVideoRenderer get videoRenderer => _renderer;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            _buildVideoView(constraints));
  }

  Widget _buildVideoView(BoxConstraints constraints) {
    return Center(
      child: Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: FittedBox(
          clipBehavior: Clip.hardEdge,
          fit: objectFit == RTCVideoViewObjectFit.RTCVideoViewObjectFitContain
              ? BoxFit.contain
              : BoxFit.cover,
          child: Center(
            child: ValueListenableBuilder<RTCVideoValue>(
              valueListenable: videoRenderer,
              builder:
                  (BuildContext context, RTCVideoValue value, Widget? child) {
                return SizedBox(
                  width: constraints.maxHeight * value.aspectRatio,
                  height: constraints.maxHeight,
                  child: child,
                );
              },
              child: Transform(
                transform: Matrix4.identity()..rotateY(mirror ? -pi : 0),
                alignment: FractionalOffset.center,
                child: videoRenderer.textureId != null &&
                        videoRenderer.srcObject != null
                    ? RotatedBox(
                        quarterTurns: rotate,
                        child: Texture(
                          textureId: videoRenderer.textureId!,
                          filterQuality: filterQuality,
                        ),
                      )
                    : Container(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
