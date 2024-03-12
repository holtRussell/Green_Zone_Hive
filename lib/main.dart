import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_zone/constants.dart';
import 'package:green_zone/data_structures/country.dart';
import 'package:green_zone/data_structures/game_logic.dart';
import 'package:green_zone/data_structures/menu_state.dart';
import 'package:green_zone/data_structures/regions.dart';
import 'package:green_zone/screens/game_screen.dart';
import 'package:green_zone/widgets/country_bubble.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  // initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(GameLogicAdapter());
  Hive.registerAdapter(RegionAdapter());
  Hive.registerAdapter(CountryAdapter());
  Hive.registerAdapter(CountryBubbleAdapter());
  Hive.registerAdapter(MenuStateAdapter());

  // Open first box
  await Hive.openBox(greenZoneData);

  //startNewGame();
  if (await Hive.boxExists(greenZoneData)) {
    print("Creating new box");

    Hive.box(greenZoneData).put(0, GameLogic());
    Hive.box(greenZoneData).put(1, MenuState());
  }

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
      home: MyHomePage(title: 'Green Zone'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String title;
  MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MenuState menu;
  late GameLogic game;
  late Timer timeOffset;
  int dayCounter = 0;
  double greenValue = 0.4;
  double incrementValue = 0.02;

  @override
  void initState() {
    game = Hive.box(greenZoneData).get(0);
    menu = Hive.box(greenZoneData).get(1);

    setState(() {});

    timeOffset = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        greenValue += incrementValue;
        if (greenValue < 0.4 || greenValue > 0.8) incrementValue *= -1;
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                color: Colors.green.withOpacity(greenValue),
                fontSize: 64.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                menu.startNewGame();
                Hive.box(greenZoneData).put(0, game);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => GameScreen(game: menu.game)));
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 4.0),
                width: 330,
                height: 65,
                color: Colors.white,
                child: Center(
                  child: Text("New Game"),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                menu.startNewGame();
                Hive.box(greenZoneData).put(0, game);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => GameScreen(game: game)));
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 4.0),
                width: 330,
                height: 65,
                color: Colors.white,
                child: Center(child: Text("Continue Game")),
              ),
            ),
            //
            // TODO - Achievements Section
            // Container(
            //   margin: EdgeInsets.symmetric(vertical: 4.0),
            //   width: 330,
            //   height: 65,
            //   color: Colors.white,
            // ),
          ],
        ),
      ),
    );
  }
}
