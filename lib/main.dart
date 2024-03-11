import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_zone/constants.dart';
import 'package:green_zone/data_structures/country.dart';
import 'package:green_zone/data_structures/game_logic.dart';
import 'package:green_zone/data_structures/menu_state.dart';
import 'package:green_zone/data_structures/regions.dart';
import 'package:green_zone/widgets/country_bubble.dart';
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
  Hive.registerAdapter(MenuStateAdapter());

  // Open first box
  await Hive.openBox(greenZoneData);

  //startNewGame();
  if (await Hive.boxExists(greenZoneData))
    Hive.box(greenZoneData).put(0, MenuState());

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
  int dayCounter = 0;
  double greenValue = 0.3;
  double incrementValue = 0.1;

  @override
  void initState() {
    late Timer timeOffset;
    menu = Hive.box(greenZoneData).get(0);

    setState(() {});

    timeOffset = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        greenValue += incrementValue;
        if (greenValue == 0.3 || greenValue == 0.9) incrementValue *= -1;
        print("$incrementValue, $greenValue");
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
      body: Column(
        children: [
          Text(
            widget.title,
            style: TextStyle(
              color: Colors.green,
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
