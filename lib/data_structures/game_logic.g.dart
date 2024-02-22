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
      mapRegions: (fields[0] as List).cast<Region>(),
      canSail: fields[1] as bool,
      startGame: fields[2] as bool,
    )
      ..productionRate = fields[3] as int
      ..adoptionRate = fields[4] as int
      ..efficiencyRate = fields[5] as int
      ..powerUps = (fields[6] as List)
          .map((dynamic e) => (e as List).cast<PowerUp>())
          .toList();
  }

  @override
  void write(BinaryWriter writer, GameLogic obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.mapRegions)
      ..writeByte(1)
      ..write(obj.canSail)
      ..writeByte(2)
      ..write(obj.startGame)
      ..writeByte(3)
      ..write(obj.productionRate)
      ..writeByte(4)
      ..write(obj.adoptionRate)
      ..writeByte(5)
      ..write(obj.efficiencyRate)
      ..writeByte(6)
      ..write(obj.powerUps);
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
