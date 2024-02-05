import 'package:flutter/material.dart';
import 'package:green_zone/regions.dart';
import 'package:hive/hive.dart';

part 'country.g.dart';

@HiveType(typeId: 2)
class Country {
  int maximumEnergy;

  @HiveField(0)
  String name;

  @HiveField(1)
  String abbreviation;

  @HiveField(2)
  int currentEnergy;

  Country({
    required this.name,
    required this.abbreviation,
    this.currentEnergy = 0,
    this.maximumEnergy =
        500, // Scores range from 300, 500, 1000, 1,500 for mondo countries
  });
}
