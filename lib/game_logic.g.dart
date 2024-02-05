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
    );
  }

  @override
  void write(BinaryWriter writer, GameLogic obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.mapRegions)
      ..writeByte(1)
      ..write(obj.canSail)
      ..writeByte(2)
      ..write(obj.startGame);
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
