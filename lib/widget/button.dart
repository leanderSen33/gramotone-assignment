import 'package:flutter/material.dart';

//import 'package:gramotone_tasks/page/play_page.dart';

import 'package:gramotone_tasks/page/play_page.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.video1,
    required this.video2,
    required this.appBarTitle,
    required this.buttonTitle,
  }) : super(key: key);

  final String video1;
  final String video2;
  final String appBarTitle;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(32),
        ),
        side: BorderSide(color: Colors.black45, width: 1),
      ),
      color: const Color(0xfff3b840),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayPage(
              video1: video1,
              video2: video2,
              appBarTitle: appBarTitle,
            ),
          ),
        );
      },
      minWidth: 240,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Text(
        buttonTitle,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
