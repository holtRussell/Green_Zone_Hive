import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../constants.dart';
import 'game_logic.dart';

class PowerUp {
  final String title;

  final String description;

  final String effect;

  final VoidCallback callback;

  final int cost;

  bool isActive;

  bool isLocked;

  bool isSelected;

  PowerUp(
      {required this.title,
      required this.description,
      required this.effect,
      required this.callback,
      this.isActive = false,
      this.isSelected = false,
      this.isLocked = true,
      required this.cost});
}

List<List<PowerUp>> abilities = [
  [
    PowerUp(
      title: "Sailing",
      description:
          "Allow your technology to cross oceans and spread to new shores",
      effect: "Sail across the sea",
      isActive: false,
      isSelected: false,
      isLocked: false,
      cost: 3,
      callback: () {
        GameLogic game = Hive.box(greenZoneData).get(0);
        game.canSail = true;
        game.adoptionRate += 1;
        Hive.box(greenZoneData).put(0, game);
      },
    ),
    PowerUp(
      title: "Sailing++",
      description: "Transport your tech to new borders faster than ever before",
      effect: "+3 Adoption Rate",
      cost: 5,
      callback: () {
        GameLogic game = Hive.box(greenZoneData).get(0);
        game.adoptionRate += 3;
        Hive.box(greenZoneData).put(0, game);
      },
    ),
    PowerUp(
      title: "Air Travel",
      description:
          "Greatly increase the speed your tech spreads to new countries",
      effect: "+5 Adoption Rate",
      cost: 9,
      callback: () {
        GameLogic game = Hive.box(greenZoneData).get(0);
        game.adoptionRate += 5;
        Hive.box(greenZoneData).put(0, game);
      },
    ),
    PowerUp(
      title: "Superconductor Grid",
      description:
          "Massively increases the adoption rate of your tech between borders",
      effect: "+8 Adoption Rate",
      cost: 12,
      callback: () {
        GameLogic game = Hive.box(greenZoneData).get(0);
        game.adoptionRate += 8;
        print(game.adoptionRate);
        Hive.box(greenZoneData).put(0, game);
      },
    ),
  ],
  [
    PowerUp(
      title: "Lithium Battery",
      description: "Boosts excess energy produced by countries",
      effect: '+1 Energy rate',
      cost: 3,
      isActive: false,
      isSelected: false,
      isLocked: false,
      callback: () {
        GameLogic game = Hive.box(greenZoneData).get(0);
        game.productionRate += 1;
        print(game.productionRate);
        Hive.box(greenZoneData).put(0, game);
      },
    ),
    PowerUp(
      title: "Batteries++",
      description: "More batteries means more energy stored",
      effect: '+3 Energy rate',
      cost: 5,
      callback: () {
        GameLogic game = Hive.box(greenZoneData).get(0);
        game.productionRate += 3;
        Hive.box(greenZoneData).put(0, game);
      },
    ),
    PowerUp(
      title: "ReEngineered",
      description:
          "Greatly increase the speed your tech spreads to new countries",
      effect: '+5 Energy rate',
      cost: 8,
      callback: () {
        GameLogic game = Hive.box(greenZoneData).get(0);
        game.productionRate += 5;
        Hive.box(greenZoneData).put(0, game);
      },
    ),
    PowerUp(
      title: "Superconductor",
      description:
          "Massively increases the adoption rate of your tech between borders",
      cost: 15,
      effect: '+8 Energy rate',
      callback: () {
        GameLogic game = Hive.box(greenZoneData).get(0);
        game.productionRate += 8;
        Hive.box(greenZoneData).put(0, game);
      },
    ),
  ],
  [
    PowerUp(
      title: "Marketing 1",
      description: "Creating awareness slows down the rate of Global Warming",
      effect: "+1 Efficiency Rate",
      isActive: false,
      isSelected: false,
      isLocked: false,
      cost: 3,
      callback: () {
        GameLogic game = Hive.box(greenZoneData).get(0);
        game.efficiencyRate += 1;
        Hive.box(greenZoneData).put(0, game);
      },
    ),
    PowerUp(
      title: "Marketing++",
      description: "Greatly reduces the rate of Global Warming",
      effect: "+3 Efficiency Rate",
      cost: 5,
      callback: () {
        GameLogic game = Hive.box(greenZoneData).get(0);
        game.efficiencyRate += 3;
        Hive.box(greenZoneData).put(0, game);
      },
    ),
    PowerUp(
      title: "Lobbying",
      description:
          "Urge Governments to slow down their consumption rates, greatly reduces Global Warming rate",
      effect: "+5 Efficiency Rate",
      cost: 9,
      callback: () {
        GameLogic game = Hive.box(greenZoneData).get(0);
        game.efficiencyRate += 5;
        Hive.box(greenZoneData).put(0, game);
      },
    ),
    PowerUp(
      title: "Regulations",
      description:
          "Adding regulations massively decreases the rate of Global Warming",
      effect: "+20 Efficiency Rate",
      cost: 15,
      callback: () {
        GameLogic game = Hive.box(greenZoneData).get(0);
        game.efficiencyRate += 8;
        Hive.box(greenZoneData).put(0, game);
      },
    ),
  ],
];
