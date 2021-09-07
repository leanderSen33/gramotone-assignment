import 'package:flutter/material.dart';
import 'dart:async';

import 'package:gramotone_tasks/widgets/play_and_pause_button.dart';
import 'package:video_player/video_player.dart';
import '../main.dart';

class PlayPage extends StatefulWidget {
  late final String video1;
  late final String video2;
  late final String appBarTitle;

  PlayPage(
      {required this.video1, required this.video2, required this.appBarTitle});

  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  late VideoPlayerController _controller1;
  late VideoPlayerController _controller2;

// This gives the CircularProgressIndicator time to spin one time so we can avoid
// the glitch effect when it loads too fast.
  Future sleep() {
    return new Future.delayed(const Duration(milliseconds: 700), () => "1");
  }

  @override
  void initState() {
    _controller1 = VideoPlayerController.asset(
      widget.video1,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )
      ..initialize().then(
        (_) async {
          // Ensure the first frame is shown after the video is initialized,
          //even before the play button has been pressed.
          await sleep();
          setState(() {});
        },
      )
      ..setLooping(true);

    _controller2 = VideoPlayerController.asset(
      widget.video2,
      videoPlayerOptions:
          VideoPlayerOptions(mixWithOthers: true), // MixWithOthers makes
      // possible to play the two videos in parallel at the same time.
    )
      ..initialize().then(
        (_) async {
          await sleep();
          setState(() {});
        },
      )
      ..setLooping(true);

    super.initState();
  }

  var value = false;

  @override
  Widget build(BuildContext context) {
    // Store AppBar in a variable so we can access it from anywhere.

    final appBar = AppBar(
      backgroundColor: Color(0xfff3b840),
      leading: IconButton(
        icon: Icon(Icons.navigate_before),
        iconSize: 30.0,
        onPressed: () {
          Navigator.pop(
            context,
            MaterialPageRoute(builder: (context) => IntroPage()),
          );
        },
      ),
      centerTitle: true,
      title: Text(widget.appBarTitle),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Switch(
                  thumbColor: MaterialStateProperty.all(Colors.white),
                  trackColor: MaterialStateProperty.all(Color(0xff2c3030)),
                  value: value,
                  onChanged: (value) => setState(() => this.value = value),
                ),
                Text('Fit Video    '),
              ],
            ),
          ),
        ),
      ],
    );

    final halfWidth = MediaQuery.of(context).size.width * 0.5;

    final halfHeight = (MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            kToolbarHeight) *
        0.5;

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    List<Widget> layoutVideos(double halfOfWidth, double halfOfHeight) {
      return [
        Expanded(
          child: Container(
            height: isLandscape ? halfOfWidth * 2 : halfOfHeight,
            width: halfOfWidth * 2,
            child: FittedBox(
              fit: value ? BoxFit.fill : BoxFit.contain,
              child: SizedBox(
                width: _controller1.value.size.width,
                height: _controller1.value.size.height,
                child: AspectRatio(
                  aspectRatio: _controller1.value.aspectRatio,
                  child: VideoPlayer(_controller1),
                ),
              ),
            ),
          ),
        ),
        Stack(
          alignment: Alignment.centerRight,
          clipBehavior: Clip.none,
          children: [
            Container(
              height: isLandscape ? halfHeight * 2 : halfHeight,
              width: isLandscape ? halfOfWidth : halfOfWidth * 2,
              child: FittedBox(
                fit: value ? BoxFit.fill : BoxFit.contain,
                child: SizedBox(
                  width: _controller2.value.size.width,
                  height: _controller2.value.size.height,
                  child: AspectRatio(
                    aspectRatio: _controller2.value.aspectRatio,
                    child: VideoPlayer(_controller2),
                  ),
                ),
              ),
            ),
            Positioned(
              //left: -32.5,
              top: isLandscape ? null : -32.5,
              right: halfWidth - 35,
              child: PlayAndPauseButton(
                controller1: _controller1,
                controller2: _controller2,
                setState: () {
                  setState(() {
                    togglePlaying();
                  });
                },
              ),
            ),
            _controller1.value.isInitialized && _controller2.value.isInitialized
                ? Container()
                : Positioned(
                    //left: -32.5,
                    top: isLandscape ? null : -32.5,
                    right: halfWidth - 35,
                    child: SizedBox(
                      height: 70,
                      width: 70,
                      child: CircularProgressIndicator(
                        color: Color(0xfff3b840),
                      ),
                    ),
                  ),
          ],
        ),
      ];
    }

    return Scaffold(
      backgroundColor: const Color(0xff2c3030),
      appBar: appBar,
      body: Container(
        child: Builder(
          builder: (context) {
            if (isLandscape) {
              return Row(
                children: layoutVideos(halfWidth, halfHeight),
              );
            } else {
              return Column(
                children: layoutVideos(halfWidth, halfHeight),
              );
            }
          },
        ),
      ),
    );
  }

  void startBothPlayers() async {
    await _controller1.play();
    await _controller2.play();
  }

  void stopBothPlayers() async {
    await _controller1.pause();
    await _controller2.pause();
  }

  void togglePlaying() {
    _controller1.value.isPlaying || _controller2.value.isPlaying
        ? stopBothPlayers()
        : startBothPlayers();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }
}
