import 'dart:async';

import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_zone/constants.dart';
import 'package:green_zone/data_structures/country.dart';
import 'package:green_zone/data_structures/game_logic.dart';
import 'package:green_zone/data_structures/regions.dart';
import 'package:green_zone/widgets/country_bubble.dart';
import 'package:green_zone/widgets/power_up_page.dart';
import 'package:hive_flutter/adapters.dart';

void startNewGame() {
  GameLogic game = GameLogic();

  game.buildPowerUpState();

  Hive.box(greenZoneData).put(0, game);
}

void main() async {
  // initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(GameLogicAdapter());
  Hive.registerAdapter(RegionAdapter());
  Hive.registerAdapter(CountryAdapter());
  Hive.registerAdapter(CountryBubbleAdapter());

  // Open first box
  await Hive.openBox(greenZoneData);
  //startNewGame();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Green Zone'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late GameLogic game;
  int dayCounter = 0;

  @override
  void initState() {
    game = Hive.box(greenZoneData).get(0);
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
    // force landscape orientation
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
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
                    colors: game.getCountryColors(),

                    // Details of what area is being touched, giving you the ID, name and tapdetails
                    callback: (id, name, tapdetails) {
                      if (!game.startGame) {
                        setState(() {
                          game.selectCountry(id: id);
                        });
                      }
                      Hive.box(greenZoneData).put(0, game);
                    },
                  ),
                  if (game.countryBubbles.isNotEmpty) ...game.countryBubbles,
                  Positioned(
                    bottom: 0.0,
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
                              Text("${game.currentDay}"),
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
                              Text("${game.emissionsMultiplier}x"),
                              Container(
                                height: 30.0,
                                width: 90.0,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Colors.blue,
                                    Colors.blueGrey
                                  ], stops: [
                                    game.emissionsLevel / 10000,
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
                                  "${game.energyLevel}",
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
                  if (game.hasLost || game.hasWon)
                    Container(
                      color: Colors.red,
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height - 50,
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        children: [
                          Text(
                            game.hasWon ? "YOU WON!!!" : "YOU LOST :(",
                            style: TextStyle(
                                fontSize: 32.0, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            game.hasWon
                                ? "The world has embraced alternative energy. There's a bright, carbon negative future ahead :)"
                                : "Our reliance on fossil fuels caused the earth to become inhabitable. Maybe we'll do better on the next planet we occupy...",
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Back To Menu"))
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
