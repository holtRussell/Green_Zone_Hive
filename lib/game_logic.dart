import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:green_zone/constants.dart';

import 'package:green_zone/regions.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'game_logic.g.dart';

// Unique Hive ID for Game Logic
@HiveType(typeId: 0)
class GameLogic {
  // Values that need saving
  @HiveField(0)
  List<Region> mapRegions;
  @HiveField(1)
  bool canSail;
  @HiveField(2)
  bool startGame;

  GameLogic({
    required this.mapRegions,
    this.canSail = false,
    this.startGame = false,
  });

  void updateGame() {
    // todo -- Show how stupid I am...
    //  List<Region> mapRegions = regions;

    int greenValue = 65;
    int selectedRegion = 0;
    Random randomController = Random();


    // print(mapRegions[0].isActive);

    for (var region in mapRegions) {
      //print(region.name);
      if (region.isActive) {
        //print(region.name);
        region.countries.forEach((country) {
          //print(country.name);
          country.currentEnergy > country.maximumEnergy - 5 ? country.currentEnergy = country.maximumEnergy : country.currentEnergy += randomController.nextInt(5);

          //print(country.currentEnergy);
        });



        if (randomController.nextInt(50) == 0) {
          if (canSail == true) {
            mapRegions[randomController.nextInt(mapRegions.length)].isActive =
                true;
          } else {

            mapRegions[region.adjacentRegions[
                    randomController.nextInt(region.adjacentRegions.length)]]
                .isActive = true;
          }
        }
      }
    }
  }

  Map<dynamic, dynamic> getCountryColors() {

    return {
      for (var region in mapRegions)
        if (region.isActive)
          for (var country in region.countries)
            country.abbreviation: Color.fromRGBO(
              45,
              45 +
                  (country.currentEnergy / country.maximumEnergy * 210).toInt(),
              45,
              1.0,
            ),
    };
  }

  selectCountry({required String id}) {
    for (int i = 0; i < mapRegions.length; i++) {
      for (var country in mapRegions[i].countries) {
        if (country.abbreviation == id) {
          startGame = true;
          mapRegions[i].isActive = true;
          this.canSail = mapRegions[i].canSail;
          print(mapRegions[i].name);
          print(canSail);
          return;
        }
      }
    }
  }
}
