import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../data_structures/regions.dart';

part 'country_bubble.g.dart';

@HiveType(typeId: 3)
class CountryBubble extends StatelessWidget {
  @HiveField(0)
  Region region;

  @HiveField(1)
  int callbackIndex;

  VoidCallback callback = () {};

  CountryBubble({required this.region, required this.callbackIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.sizeOf(context).height * region.verticalOffset / 100,
      left: MediaQuery.sizeOf(context).width * region.horizontalOffset / 100,
      child: GestureDetector(
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
        onTap: callback,
      ),
    );
  }
}
