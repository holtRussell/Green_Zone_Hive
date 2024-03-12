import 'dart:async';

import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/material.dart';
import 'package:green_zone/constants.dart';
import 'package:green_zone/data_structures/game_logic.dart';
import 'package:hive/hive.dart';

import '../widgets/power_up_page.dart';

class GameScreen extends StatefulWidget {
  GameLogic game;
  GameScreen({required this.game, super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int dayCounter = 0;
  late Timer timeOffset;
  late GameLogic game;

  @override
  void initState() {
    game = Hive.box(greenZoneData).get(0);
    game.buildPowerUpState();
    game.buildPowerUpList();
    game.loadEnergyList();
    //
    setState(() {});

    timeOffset = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      widget.game = Hive.box(greenZoneData).get(0);
      if (widget.game.hasWon || widget.game.hasLost) timeOffset.cancel();
      setState(() {
        dayCounter = (dayCounter + 1) % 5;
        if (dayCounter == 0 && game.startGame) widget.game.currentDay += 1;
        widget.game.updateGame();
        Hive.box(greenZoneData).put(0, widget.game);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                InteractiveViewer(
                  child: Stack(
                    children: [
                      SimpleMap(
                        // String of instructions to draw the map.
                        instructions: SMapWorld.instructions,

                        // Default color for all countries.
                        defaultColor: const Color.fromRGBO(45, 45, 45, 1.0),
                        countryBorder: const CountryBorder(
                            color: Colors.black, width: 1.0),

                        // Matching class to specify custom colors for each area.
                        colors: widget.game.getCountryColors(),

                        // Details of what area is being touched, giving you the ID, name and tapdetails
                        callback: (id, name, tapdetails) {
                          if (!widget.game.startGame) {
                            setState(() {
                              widget.game.selectCountry(id: id);
                            });
                          }
                          Hive.box(greenZoneData).put(0, widget.game);
                        },
                      ),
                      if (widget.game.countryBubbles.isNotEmpty)
                        ...widget.game.countryBubbles,
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  left: MediaQuery.sizeOf(context).width / 2 - 105,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      //
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.0,
                          vertical: 3.0,
                        ),
                        width: 60.0,
                        height: 40.0,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Text(
                              "Day:",
                              style: TextStyle(
                                  fontSize: 10.0, fontWeight: FontWeight.w200),
                            ),
                            Text("${widget.game.currentDay}"),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.0,
                          vertical: 3.0,
                        ),
                        width: 90.0,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${widget.game.emissionsMultiplier}x"),
                            Container(
                              height: 30.0,
                              width: 90.0,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.blue,
                                  Colors.blueGrey
                                ], stops: [
                                  0.0,
                                  widget.game.emissionsLevel / 10000,
                                ]),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => PowerUpPage(
                                        game: widget.game,
                                      )));
                        },
                        child: Container(
                          height: 40.0,
                          width: 60.0,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${widget.game.energyLevel}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0,
                                ),
                              ),
                              Icon(
                                Icons.bolt,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.game.hasLost || widget.game.hasWon)
                  Container(
                    color: Colors.white,
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height - 100,
                    margin: EdgeInsets.symmetric(
                      horizontal: 100.0,
                      vertical: 30.0,
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 35.0, vertical: 20.0),
                    child: Column(
                      children: [
                        Text(
                          widget.game.hasWon ? "YOU WON!!!" : "YOU LOST :(",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 32.0, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          widget.game.hasWon
                              ? "The world has embraced alternative energy. There's a bright, carbon negative future ahead :)"
                              : "Our reliance on fossil fuels caused the earth to become uninhabitable. Maybe we'll do better on the next planet we occupy...",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            game = GameLogic();
                            Hive.box(greenZoneData).put(0, game);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2.0,
                                )),
                            child: Text(
                              "Back To Menu",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
