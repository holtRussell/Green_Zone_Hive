import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_zone/constants.dart';
import 'package:green_zone/data_structures/game_logic.dart';
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
                          game.powerUps[currentIndex][selectedPowerUp]
                              .isSelected = false;
                          selectedPowerUp = index;

                          game.powerUps[currentIndex][selectedPowerUp]
                              .isSelected = true;
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
                            game.powerUps[currentIndex][selectedPowerUp].title,
                            style: const TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            game.powerUps[currentIndex][selectedPowerUp]
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
                          Text(game
                              .powerUps[currentIndex][selectedPowerUp].effect),
                          const SizedBox(
                            height: 12.0,
                          ),
                          GestureDetector(
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              color: game
                                      .powerUps[currentIndex][selectedPowerUp]
                                      .isActive
                                  ? Colors.green
                                  : Colors.grey,
                              child: Center(
                                child: Text(
                                  game.powerUps[currentIndex][selectedPowerUp]
                                          .isActive
                                      ? "Purchased"
                                      : "Purchase for ${game.powerUps[currentIndex][selectedPowerUp].cost} energy",
                                ),
                              ),
                            ),
                            onTap: game.powerUps[currentIndex][selectedPowerUp]
                                    .isActive
                                ? () {}
                                : () {
                                    setState(() {
                                      if (game.energyLevel >=
                                          game
                                              .powerUps[currentIndex]
                                                  [selectedPowerUp]
                                              .cost) {
                                        game.energyLevel -= game
                                            .powerUps[currentIndex]
                                                [selectedPowerUp]
                                            .cost;
                                        // I forgot to add the () to the callback, and it took a week to figure out ;)
                                        game.powerUps[currentIndex]
                                                [selectedPowerUp]
                                            .callback();

                                        // Activates the current power up
                                        game
                                            .powerUps[currentIndex]
                                                [selectedPowerUp]
                                            .isActive = true;
                                        game.powerUpState[currentIndex]
                                            [selectedPowerUp] = 2;
                                        Hive.box(greenZoneData).put(0, game);

                                        // Unlock the next power up (if applicable)
                                        if (selectedPowerUp ==
                                            game.powerUps[currentIndex].length -
                                                1) return;
                                        game
                                            .powerUps[currentIndex]
                                                [selectedPowerUp + 1]
                                            .isLocked = false;
                                        game.powerUpState[currentIndex]
                                            [selectedPowerUp + 1] = 1;
                                        Hive.box(greenZoneData).put(0, game);
                                      }
                                    });
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
                  itemCount: game.powerUps.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                        child: Container(
                          width: MediaQuery.sizeOf(context).width / 3,
                          height: 60,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          color: index == currentIndex
                              ? Colors.white
                              : CupertinoColors.inactiveGray,
                          child: Center(
                              child: Text(
                            getPowerUpLabel(index),
                            style: TextStyle(
                                fontWeight: index == currentIndex
                                    ? FontWeight.w600
                                    : FontWeight.w400),
                          )),
                        ),
                        onTap: () {
                          setState(() {
                            game.powerUps[currentIndex][selectedPowerUp]
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

  String getPowerUpLabel(int index) {
    if (index == 0) return "Adoption";
    if (index == 1) return "Production";
    return "Efficiency";
  }
}
