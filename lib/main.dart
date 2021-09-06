import 'package:flutter/material.dart';
import 'package:gramotone_tasks/widgets/task_button.dart';
import 'package:flutter/services.dart';

void main() {
  // Set portrait orientation only.
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'gramotone tasks',
      home: IntroPage(),
    );
  }
}

class IntroPage extends StatelessWidget {
  final videoAcordion = 'videos/accordion.mp4';
  final videoGuitar = 'videos/guitar.mp4';
  final videoDrums = 'videos/drums.mp4';
  final taskA = 'Task A';
  final taskB = 'Task B';
  final titleMainPage = 'gramotone';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2c3030),
      body: SafeArea(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 120,
              ),
              Text(
                titleMainPage,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TaskButton(
                      video1: videoDrums,
                      video2: videoDrums,
                      appBarTitle: taskA,
                      buttonTitle: taskA,
                    ),
                    SizedBox(height: 20),
                    TaskButton(
                      video1: videoAcordion,
                      video2: videoGuitar,
                      appBarTitle: taskB,
                      buttonTitle: taskB,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
