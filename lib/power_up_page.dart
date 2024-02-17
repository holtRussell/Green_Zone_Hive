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
          padding: const EdgeInsets.all(16),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.sailing,
            size: 24,
          ),
        )),
        Positioned(
            top: 30,
            left: 100,
            child: MaterialButton(
          onPressed: () {
            GameLogic game = Hive.box(greenZoneData).get(0);
            game.adoptionRate += 5;
            Hive.box(greenZoneData).put(0, game);
          },
          color: Colors.green,
          textColor: Colors.white,
          padding: const EdgeInsets.all(16),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.sailing,
            size: 24,
          ),
        )),
        Positioned(
            right: 20,
            top: 20,
            child: MaterialButton(
          onPressed: () {
            GameLogic game = Hive.box(greenZoneData).get(0);
            game.adoptionRate += 10;
            Hive.box(greenZoneData).put(0, game);
          },
          color: Colors.green,
          textColor: Colors.white,
          padding: const EdgeInsets.all(16),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.airplanemode_on,
            size: 24,
          ),
        )),
        Positioned(
            right: 20,
            bottom: 20,
            child: MaterialButton(
              onPressed: () {
                GameLogic game = Hive.box(greenZoneData).get(0);
                game.adoptionRate += 100;
                Hive.box(greenZoneData).put(0, game);
              },
              color: Colors.green,
              textColor: Colors.white,
              padding: const EdgeInsets.all(16),
              shape: const CircleBorder(),
              child: const Icon(
                Icons.grid_4x4,
                size: 24,
              ),
            )),
      ],
    );
  }
}
