import 'dart:async';
import 'dart:math';

import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_zone/constants.dart';
import 'package:green_zone/country.dart';
import 'package:green_zone/game_logic.dart';
import 'package:green_zone/power_up_page.dart';
import 'package:green_zone/regions.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  // initialize Hive
  await Hive.initFlutter();

  Hive.registerAdapter(GameLogicAdapter());
  Hive.registerAdapter(RegionAdapter());
  Hive.registerAdapter(CountryAdapter());

  // Open first box
  // await Hive.box(greenZoneData).deleteFromDisk();
  await Hive.openBox(greenZoneData);
  Hive.box(greenZoneData ).put(0, GameLogic(mapRegions: regions));

  //print("deleted");

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
    //game.mapRegions[0].countries[0].currentEnergy = game.mapRegions[0].countries[0].maximumEnergy;
    print(game.startGame);
    print(game.canSail);
    print(game.mapRegions[0].isActive);
    print(game.mapRegions[1].isActive);
    print(game.mapRegions[2].isActive);
    print(game.mapRegions[0].countries[0].currentEnergy);
    Timer timeOffset = Timer.periodic(Duration(milliseconds: 50), (timer) {
      game = Hive.box(greenZoneData).get(0);
      setState(() {
        game.updateGame();
        Hive.box(greenZoneData).put(0, game);
      });


    });

    super.initState();
  }

  // todo -- So, there's two operations:
  //  1) Rendering (This is always O(n))    - Should work from a list of Countires
  //  2) updating, which is by region, and can exclude inactive regions
  // If I pair regions to countries in initialization, I can

  @override
  Widget build(BuildContext context) {
    // force landscape orientation
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (_) => PowerUpPage()));},),
      body: SafeArea(
        child: Center(
          child: InteractiveViewer(
            child: SimpleMap(
              // String of instructions to draw the map.
              instructions: SMapWorld.instructions,

              // Default color for all countries.
              defaultColor: Color.fromRGBO(45, 45, 45, 1.0),
              countryBorder: CountryBorder(color: Colors.black, width: 1.0),

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
          ),
        ),
      ),

    );

  }
}
