// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regions.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegionAdapter extends TypeAdapter<Region> {
  @override
  final int typeId = 1;

  @override
  Region read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Region(
      countries: (fields[2] as List).cast<Country>(),
      name: fields[0] as String,
      adjacentRegions: (fields[1] as List).cast<int>(),
      verticalOffset: fields[6] as int,
      horizontalOffset: fields[7] as int,
      canSail: fields[4] as bool,
      hasBubble: fields[5] as bool,
      isActive: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Region obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.adjacentRegions)
      ..writeByte(2)
      ..write(obj.countries)
      ..writeByte(3)
      ..write(obj.isActive)
      ..writeByte(4)
      ..write(obj.canSail)
      ..writeByte(5)
      ..write(obj.hasBubble)
      ..writeByte(6)
      ..write(obj.verticalOffset)
      ..writeByte(7)
      ..write(obj.horizontalOffset);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
