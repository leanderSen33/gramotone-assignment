import 'package:flutter/material.dart';

// This Branch hasen't used yet this Widget.

List<Widget> layoutVideos(
    double halfOfWidth, double halfOfHeight, bool isLandscape) {
  return [
    Expanded(
      child: Container(
        height: isLandscape ? halfOfWidth * 2 : halfOfHeight,
        width: halfOfWidth * 2,
        color: Colors.green,
      ),
    ),
    Stack(
      alignment: Alignment.centerRight,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: isLandscape ? halfOfHeight * 2 : halfOfHeight,
          width: isLandscape ? halfOfWidth : halfOfWidth * 2,
          color: Colors.black,
        ),
        Positioned(
          //left: -32.5,
          top: isLandscape ? null : -32.5,
          right: halfOfWidth - 35,
          child: GestureDetector(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                height: 70,
                width: 70,
                color: Colors.white.withOpacity(0.5),
                child: Icon(
                  Icons.play_arrow,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ];
}
