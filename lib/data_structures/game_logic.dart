import 'dart:math';

import 'package:flutter/material.dart';
import 'package:green_zone/data_structures/power_up.dart';
import 'package:green_zone/data_structures/regions.dart';
import 'package:green_zone/widgets/country_bubble.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'game_logic.g.dart';

// Unique Hive ID for Game Logic
@HiveType(typeId: 0)
class GameLogic {
  // Values that need saving

  @HiveField(0)
  bool canSail;
  @HiveField(1)
  bool startGame;

  GameLogic({
    this.canSail = false,
    this.startGame = false,
  });

  @HiveField(2)
  List<Region> mapRegions = regions;

  int greenValue = 65;
  //
  int selectedRegion = 0;

  Random randomController = Random();

  // Increases amount of energy produced
  @HiveField(3)
  int productionRate = 1;

  // % Chance of spreading to other countries
  @HiveField(4)
  int adoptionRate = 1;

  // the more efficient your production, the easier you can counter Carbon Emissions
  @HiveField(5)
  int efficiencyRate = 1;

  @HiveField(6)
  List<List<int>> powerUpState = [];

  @HiveField(7)
  List<CountryBubble> countryBubbles = [];

  late List<List<PowerUp>> powerUps = abilities;

  void updateGame() {
    for (var region in mapRegions) {
      regionTasks(region: region);
    }
  }

  buildPowerUpState() {
    for (int i = 0; i < abilities.length; i++) {
      powerUpState.add([]);
      for (int j = 0; j < abilities[i].length; j++) {
        powerUpState[i].add(0);
      }
    }
  }

  void buildPowerUpList() {
    for (int i = 0; i < abilities.length; i++) {
      powerUpState.add([]);
      for (int j = 0; j < abilities[i].length; j++) {
        getPowerUpState(powerUp: powerUps[i][j], state: powerUpState[i][j]);
      }
    }
  }

  void getPowerUpState({required PowerUp powerUp, required int state}) {
    // 0 means locked
    if (state == 0) {
      return;
    }

    // both 1 and 2 will be unlocked
    powerUp.isLocked = false;

    if (state == 1) return;

    // 2 means powerup is purchased
    powerUp.isActive = true;
    return;
  }

  regionTasks({required Region region}) {
    if (!region.isActive) return;

    // Updates the country energy levels in the region
    updateCountryColor(region: region, offset: productionRate + 1);

    // Spreads energy to another region
    spreadRegion(region: region);

    spawnEnergy(region: region);
  }

  spawnEnergy({required Region region}) {
    if (region.hasBubble) return;

    // if (randomController.nextInt(20000) > productionRate) return;

    region.hasBubble = true;
    countryBubbles.add(CountryBubble(region: region));
  }

  updateCountryColor({required Region region, required int offset}) {
    //Loops through each country to update energy Level (color)
    for (var country in region.countries) {
      // Updates country
      country.currentEnergy > country.maximumEnergy - offset
          ? country.currentEnergy = country.maximumEnergy
          : country.currentEnergy += randomController.nextInt(offset);
    }
  }

  spreadRegion({required Region region}) {
    // triggers spread event if random is less than DR
    if (randomController.nextInt(20000) > adoptionRate) return;

    // if canSail, selects from global list rather than adjacent countries
    if (canSail == true) {
      mapRegions[randomController.nextInt(mapRegions.length)].isActive = true;
      return;
    }

    mapRegions[region.adjacentRegions[
            randomController.nextInt(region.adjacentRegions.length)]]
        .isActive = true;
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
          canSail = mapRegions[i].canSail;
          print(mapRegions[i].name);
          print(canSail);
          return;
        }
      }
    }
  }
}
