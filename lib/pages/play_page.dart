import 'package:flutter/material.dart';
import 'package:gramotone_tasks/widgets/play_and_pause_button.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

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
    );

// Substract appBar height and padding to the total height to get the available height.
    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
// Total availeble width.
    final availableWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Container(
          color: Color(0xff2c3030),
          height: availableHeight,
          width: availableWidth,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: <Widget>[
              Container(
                // Check if the first video is inizialized, if true, show the first frame.
                // If not, show an empy cotainer.
                child: _controller1.value.isInitialized
                    ? Positioned(
                        top: 0,
                        child: Container(
                          height:
                              availableHeight * 0.50, // take half of the screen
                          child: AspectRatio(
                            aspectRatio: _controller1.value.aspectRatio,
                            child: VideoPlayer(_controller1),
                          ),
                        ),
                      )
                    : Container(),
              ),
              Container(
                // Check if the second video is inizialized, if true, show the first frame.
                // If not, show an empy cotainer.
                child: _controller2.value.isInitialized
                    ? Positioned(
                        bottom: 0,
                        child: Container(
                          height:
                              availableHeight * 0.50, // take half of the screen
                          child: AspectRatio(
                            aspectRatio: _controller2.value.aspectRatio,
                            child: VideoPlayer(_controller2),
                          ),
                        ),
                      )
                    : Container(),
              ),
              Positioned(
                top: (availableHeight - 70) * 0.5,
                width: availableWidth * 0.5,
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
              _controller1.value.isInitialized &&
                      _controller2.value.isInitialized
                  ? Container()
                  : Positioned(
                      top: (availableHeight - 70) / 2,
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
