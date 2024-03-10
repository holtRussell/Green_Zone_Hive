import 'dart:async';

import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_zone/constants.dart';
import 'package:green_zone/data_structures/country.dart';
import 'package:green_zone/data_structures/game_logic.dart';
import 'package:green_zone/data_structures/regions.dart';
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

  // Open first box
  await Hive.openBox(greenZoneData);
  startNewGame();

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

  @override
  void initState() {
    game = Hive.box(greenZoneData).get(0);

    game.buildPowerUpList();

    Hive.box(greenZoneData).put(0, game);
    setState(() {});
    print(game.startGame);
    print(game.canSail);
    print(game.mapRegions[0].isActive);
    print(game.mapRegions[1].isActive);
    print(game.mapRegions[2].isActive);
    print(game.mapRegions[0].countries[0].currentEnergy);
    print(game.productionRate);
    print(game.adoptionRate);
    print(game.efficiencyRate);

    Timer timeOffset =
        Timer.periodic(const Duration(milliseconds: 30), (timer) {
      game = Hive.box(greenZoneData).get(0);
      setState(() {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const PowerUpPage()));
        },
      ),
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
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              "${game.energyLevel}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                              ),
                            ),
                            Icon(
                              Icons.bolt,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ))
                  // Container(
                  //   width: MediaQuery.sizeOf(context).width,
                  //   height: 60,
                  //   color: Colors.red,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text("News Placeholder"),
                  //       Text(
                  //         "Date",
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 22.0,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Positioned(
                  //   bottom: 0.0,
                  //   left: 0.0,
                  //   child: Container(
                  //     width: MediaQuery.sizeOf(context).width,
                  //     height: 40,
                  //     color: Colors.green,
                  //     child: Row(
                  //       children: [
                  //         Container(
                  //           color: Colors.blue,
                  //         ),
                  //         TextButton(
                  //             onPressed: () {},
                  //             child: Text(
                  //               "Press Me :)",
                  //               style: TextStyle(
                  //                 fontSize: 30.0,
                  //               ),
                  //             ))
                  //       ],
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
