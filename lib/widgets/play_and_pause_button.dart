import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayAndPauseButton extends StatelessWidget {
  final VoidCallback setState;
  final VideoPlayerController controller1;
  final VideoPlayerController controller2;

  const PlayAndPauseButton(
      {required this.setState,
      required this.controller1,
      required this.controller2});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 70, height: 70),
      child: ElevatedButton(
        child: Icon(
          controller1.value.isPlaying || controller2.value.isPlaying
              ? Icons.pause
              : Icons.play_arrow,
          color: Color(0xff2c3030),
          size: 40,
        ),
        onPressed: setState,
        style: ElevatedButton.styleFrom(
          elevation: 3,
          primary: Colors.white.withOpacity(0.7),
          shape: CircleBorder(),
        ),
      ),
    );
  }
}
