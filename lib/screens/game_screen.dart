import 'dart:async';

import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/material.dart';
import 'package:green_zone/constants.dart';
import 'package:green_zone/data_structures/game_logic.dart';
import 'package:green_zone/widgets/power_up_page.dart';
import 'package:hive_flutter/adapters.dart';

class GameScreen extends StatefulWidget {
  GameLogic game;
  GameScreen({required this.game, super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameLogic game;
  int dayCounter = 0;

  @override
  void initState() {
    late Timer timeOffset;

    game.buildPowerUpList();
    game.loadEnergyList();

    setState(() {});

    timeOffset = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      game = Hive.box(greenZoneData).get(0);
      if (game.hasWon || game.hasLost) timeOffset.cancel();
      setState(() {
        dayCounter = (dayCounter + 1) % 5;
        if (dayCounter == 0) game.currentDay += 1;
        game.updateGame();
        Hive.box(greenZoneData).put(0, game);
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
            InteractiveViewer(
              child: Stack(
                children: [
                  SimpleMap(
                    // String of instructions to draw the map.
                    instructions: SMapWorld.instructions,

                    // Default color for all countries.
                    defaultColor: const Color.fromRGBO(45, 45, 45, 1.0),
                    countryBorder:
                        const CountryBorder(color: Colors.black, width: 1.0),

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
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w200),
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
                                    widget.game.emissionsLevel / 10000,
                                    1.0
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
                                    builder: (_) => const PowerUpPage()));
                          },
                          child: Container(
                            height: 30.0,
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
                      height: MediaQuery.sizeOf(context).height - 50,
                      margin: EdgeInsets.symmetric(
                        horizontal: 35.0,
                        vertical: 10.0,
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 35.0, vertical: 10.0),
                      child: Column(
                        children: [
                          Text(
                            widget.game.hasWon ? "YOU WON!!!" : "YOU LOST :(",
                            style: TextStyle(
                                fontSize: 32.0, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            widget.game.hasWon
                                ? "The world has embraced alternative energy. There's a bright, carbon negative future ahead :)"
                                : "Our reliance on fossil fuels caused the earth to become inhabitable. Maybe we'll do better on the next planet we occupy...",
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Back To Menu"),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
