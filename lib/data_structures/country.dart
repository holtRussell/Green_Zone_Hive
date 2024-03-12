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
        5000, // Scores go from 5000, 7500, and 10000 for mondo countries
  });
}
