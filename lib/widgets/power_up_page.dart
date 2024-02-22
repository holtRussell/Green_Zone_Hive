import 'package:flutter/material.dart';
import 'package:green_zone/constants.dart';
import 'package:green_zone/data_structures/game_logic.dart';
import 'package:green_zone/data_structures/power_up.dart';
import 'package:green_zone/widgets/power_up_button.dart';
import 'package:hive/hive.dart';

class PowerUpPage extends StatefulWidget {
  const PowerUpPage({super.key});

  @override
  State<PowerUpPage> createState() => _PowerUpPageState();
}

class _PowerUpPageState extends State<PowerUpPage> {
  int currentIndex = 0;
  int selectedPowerUp = 0;

  // todo - Switch everything over to Game Logic instad of abilities
  late GameLogic game;

  @override
  void initState() {
    game = Hive.box(greenZoneData).get(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width / 2,
                  height: MediaQuery.sizeOf(context).height * 6 / 8,
                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                  child: ListView.builder(
                    itemCount: game.powerUps[currentIndex].length,
                    itemBuilder: (context, index) => PowerUpButton(
                      ability: game.powerUps[currentIndex][index],
                      callback: () {
                        setState(() {
                          abilities[currentIndex][selectedPowerUp].isSelected =
                              false;
                          selectedPowerUp = index;

                          abilities[currentIndex][selectedPowerUp].isSelected =
                              true;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width / 2,
                  height: MediaQuery.sizeOf(context).height * 6 / 8,
                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            abilities[currentIndex][selectedPowerUp].title,
                            style: const TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            abilities[currentIndex][selectedPowerUp]
                                .description,
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(abilities[currentIndex][selectedPowerUp].effect),
                          const SizedBox(
                            height: 12.0,
                          ),
                          GestureDetector(
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              color: Colors.blue,
                            ),
                            onTap: () {
                              abilities[currentIndex][selectedPowerUp].callback;

                              // Activates the current power up
                              game.powerUps[currentIndex][selectedPowerUp]
                                  .isActive = true;
                              Hive.box(greenZoneData).put(0, game);

                              // Unlock the next power up (if applicable)
                              if (selectedPowerUp ==
                                  abilities[currentIndex].length - 1) return;
                              game.powerUps[currentIndex][selectedPowerUp + 1]
                                  .isLocked = false;
                              Hive.box(greenZoneData).put(0, game);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 1 / 8,
              child: ListView.builder(
                  itemCount: abilities.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                        child: Container(
                          width: 120,
                          height: 60,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          color: Colors.blue,
                          child: Text("Power"),
                        ),
                        onTap: () {
                          setState(() {
                            abilities[currentIndex][selectedPowerUp]
                                .isSelected = false;
                            currentIndex = index;
                            selectedPowerUp = 0;
                          });
                        },
                      )),
            )
          ],
        ),
      ),
    );
  }
}
