import 'package:flutter/material.dart';
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

  @override
  void initState() {
    _controller1 = VideoPlayerController.asset(
      widget.video1,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized,
        //even before the play button has been pressed.
        setState(() {});
      })
      ..setLooping(true);

    _controller2 = VideoPlayerController.asset(
      widget.video2,
      videoPlayerOptions:
          VideoPlayerOptions(mixWithOthers: true), // MixWithOthers makes
      // possible to play the two videos in parallel at the same time.
    )
      ..initialize().then((_) {
        setState(() {});
      })
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: appBar,
        body: Center(
          child: Container(
            color: Color(0xff2c3030),
            height: MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  top: 0,
                  child: Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.50,
                    child: _controller1.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: _controller1.value.aspectRatio,
                            child: VideoPlayer(_controller1),
                          )
                        : CircularProgressIndicator(),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.50,
                    child: _controller2.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: _controller2.value.aspectRatio,
                            child: VideoPlayer(_controller2),
                          )
                        : CircularProgressIndicator(),
                  ),
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top -
                          50) /
                      2,
                  width: MediaQuery.of(context).size.width / 2,
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 50, height: 50),
                    child: ElevatedButton(
                      child: Icon(
                        _controller1.value.isPlaying ||
                                _controller2.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          togglePlaying();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        primary: Colors.white.withOpacity(0.7),
                        shape: CircleBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
