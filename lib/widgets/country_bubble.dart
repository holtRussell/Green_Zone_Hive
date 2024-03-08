import 'package:flutter/material.dart';

import '../data_structures/regions.dart';

class CountryBubble extends StatelessWidget {
  Region region;

  CountryBubble({required this.region, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.sizeOf(context).height * region.verticalOffset / 100,
      left: MediaQuery.sizeOf(context).width * region.horizontalOffset / 100,
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
