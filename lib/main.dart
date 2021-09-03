import 'package:flutter/material.dart';
import 'package:gramotone_tasks/widget/button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'gramotone tasks',
      home: IntroPage(),
    );
  }
}

class IntroPage extends StatefulWidget {
  IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final String videoAcordion = 'videos/jana_acordion.mp4';
  final String videoGuitar = 'videos/leandro_guitar.mp4';
  final String videoDrums = 'videos/drums.mp4';
  final String taskA = 'Task A';
  final String taskB = 'Task B';
  final String titleMainPage = 'gramotone';

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
                    Button(
                      video1: videoDrums,
                      video2: videoDrums,
                      appBarTitle: taskA,
                      buttonTitle: taskA,
                    ),
                    SizedBox(height: 20),
                    Button(
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
