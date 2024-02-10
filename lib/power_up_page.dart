import 'package:flutter/material.dart';
import 'package:green_zone/constants.dart';
import 'package:green_zone/game_logic.dart';
import 'package:hive/hive.dart';

class PowerUpPage extends StatelessWidget {
  const PowerUpPage({super.key});



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(child: MaterialButton(
          onPressed: () {
            GameLogic game = Hive.box(greenZoneData).get(0);
            game.canSail = true;
            Hive.box(greenZoneData).put(0, game);
          },
          color: Colors.green,
          textColor: Colors.white,
          child: Icon(
            Icons.sailing,
            size: 24,
          ),
          padding: EdgeInsets.all(16),
          shape: CircleBorder(),
        ))
      ],
    );
  }
}
