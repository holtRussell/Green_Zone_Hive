// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_logic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameLogicAdapter extends TypeAdapter<GameLogic> {
  @override
  final int typeId = 0;

  @override
  GameLogic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameLogic(
      canSail: fields[0] as bool,
      startGame: fields[1] as bool,
    )
      ..mapRegions = (fields[2] as List).cast<Region>()
      ..productionRate = fields[3] as int
      ..adoptionRate = fields[4] as int
      ..efficiencyRate = fields[5] as int
      ..powerUpState = (fields[6] as List)
          .map((dynamic e) => (e as List).cast<int>())
          .toList()
      ..countryBubbles = (fields[7] as List).cast<CountryBubble>()
      ..energyLevel = fields[8] as int
      ..emissionsLevel = fields[9] as int
      ..emissionsMultiplier = fields[10] as int
      ..currentDay = fields[11] as int
      ..hasWon = fields[12] as bool
      ..hasLost = fields[13] as bool
      ..regionsActivated = fields[14] as int
      ..countriesCompleted = fields[15] as int;
  }

  @override
  void write(BinaryWriter writer, GameLogic obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.canSail)
      ..writeByte(1)
      ..write(obj.startGame)
      ..writeByte(2)
      ..write(obj.mapRegions)
      ..writeByte(3)
      ..write(obj.productionRate)
      ..writeByte(4)
      ..write(obj.adoptionRate)
      ..writeByte(5)
      ..write(obj.efficiencyRate)
      ..writeByte(6)
      ..write(obj.powerUpState)
      ..writeByte(7)
      ..write(obj.countryBubbles)
      ..writeByte(8)
      ..write(obj.energyLevel)
      ..writeByte(9)
      ..write(obj.emissionsLevel)
      ..writeByte(10)
      ..write(obj.emissionsMultiplier)
      ..writeByte(11)
      ..write(obj.currentDay)
      ..writeByte(12)
      ..write(obj.hasWon)
      ..writeByte(13)
      ..write(obj.hasLost)
      ..writeByte(14)
      ..write(obj.regionsActivated)
      ..writeByte(15)
      ..write(obj.countriesCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameLogicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
