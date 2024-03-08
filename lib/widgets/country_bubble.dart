import 'package:flutter/material.dart';

class CountryBubble extends StatelessWidget {
  int verticalOffset;
  int horizontalOffset;

  CountryBubble(
      {required this.verticalOffset,
      required this.horizontalOffset,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.sizeOf(context).height * verticalOffset / 100,
      left: MediaQuery.sizeOf(context).width * horizontalOffset / 100,
      child: Container(
          height: 30.0,
          width: 30.0,
          color: Colors.white,
          child: Center(
            child: Icon(
              Icons.bolt,
              color: Colors.green,
              size: 26.0,
            ),
          )),
    );
  }
}
