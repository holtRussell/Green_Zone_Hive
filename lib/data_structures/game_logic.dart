import 'dart:math';

import 'package:flutter/material.dart';
import 'package:green_zone/data_structures/country.dart';
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
  int productionRate = 3;

  // % Chance of spreading to other countries
  @HiveField(4)
  int adoptionRate = 3;

  // the more efficient your production, the easier you can counter Carbon Emissions
  @HiveField(5)
  int efficiencyRate = 1;

  @HiveField(6)
  List<List<int>> powerUpState = [];

  @HiveField(7)
  List<CountryBubble> countryBubbles = [];

  @HiveField(8)
  int energyLevel = 5;

  @HiveField(9)
  int emissionsLevel = 0;

  @HiveField(10)
  int emissionsMultiplier = 1;

  @HiveField(11)
  int currentDay = 1;

  @HiveField(12)
  bool hasWon = false;

  @HiveField(13)
  bool hasLost = false;

  @HiveField(14)
  int regionsActivated = 0;

  @HiveField(15)
  int countriesCompleted = 0;

  late List<List<PowerUp>> powerUps = abilities;

  void updateGame() {
    if (!startGame) return;
    for (var region in mapRegions) {
      regionTasks(region: region);
    }
    print(countriesCompleted);

    incrementEmissions();
    if (currentDay % 100 == 0) emissionsMultiplier += 1;
  }

  incrementEmissions() {
    if (efficiencyRate > emissionsMultiplier) return;
    if (emissionsLevel > 10000) hasLost = true;
    emissionsLevel += emissionsMultiplier;
  }

  countCountries() {
    int count = 0;
    mapRegions.forEach((region) {
      region.countries.forEach((element) {
        count++;
      });
    });
    print(count);
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
    updateRegionColor(region: region, offset: productionRate + 1);

    // Spreads energy to another region
    spreadRegion(region: region);

    checkEnergy(region: region);

    if (countriesCompleted >= 200) hasWon = true;
  }

  checkEnergy({required Region region}) {
    if (region.hasBubble) return;

    if (randomController.nextInt(2000) > productionRate + 3 / regionsActivated)
      return;

    spawnEnergy(region: region);
  }

  spawnEnergy({required Region region}) {
    if (region.hasBubble) return;
    var bubble = CountryBubble(
      region: region,
      callbackIndex: 1,
    );
    bubble.callback = setEnergyCallback(bubble: bubble);
    region.hasBubble = true;
    countryBubbles.add(bubble);
  }

  loadEnergyList() {
    countryBubbles.forEach((element) {
      element.callback = setEnergyCallback(bubble: element);
    });
  }

  dynamic setEnergyCallback({required CountryBubble bubble}) {
    if (bubble.callbackIndex == 1) {
      return () {
        bubble.region.hasBubble = false;
        countryBubbles.remove(bubble);
        energyLevel += 1;
      };
    }
  }

  updateRegionColor({required Region region, required int offset}) {
    //Loops through each country to update energy Level (color)
    for (var country in region.countries) {
      updateCountryColor(country: country, offset: offset);
    }
  }

  updateCountryColor({required Country country, required int offset}) {
    if (country.currentEnergy == country.maximumEnergy) return;

    // Updates country

    if (country.currentEnergy < country.maximumEnergy - offset) {
      country.currentEnergy += randomController.nextInt(offset);
    } else {
      country.currentEnergy = country.maximumEnergy;
      countriesCompleted += 1;
    }
  }

  spreadRegion({required Region region}) {
    // triggers spread event if random is less than DR
    if (randomController.nextInt(2000) > adoptionRate) return;

    regionsActivated += 1;

    // if canSail, selects from global list rather than adjacent countries
    if (canSail == true) {
      int regionIndex = randomController.nextInt(mapRegions.length - 1);
      mapRegions[regionIndex].isActive = true;
      spawnEnergy(region: mapRegions[regionIndex]);
    } else {
      int regionIndex = randomController.nextInt(region.adjacentRegions.length);
      mapRegions[region.adjacentRegions[regionIndex]].isActive = true;
      spawnEnergy(region: mapRegions[region.adjacentRegions[regionIndex]]);
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
          regionsActivated += 1;
          canSail = mapRegions[i].canSail;
          spawnEnergy(region: mapRegions[i]);
          return;
        }
      }
    }
  }
}
