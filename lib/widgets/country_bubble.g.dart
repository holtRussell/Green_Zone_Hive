// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_bubble.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountryBubbleAdapter extends TypeAdapter<CountryBubble> {
  @override
  final int typeId = 3;

  @override
  CountryBubble read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CountryBubble(
      region: fields[0] as Region,
      callbackIndex: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CountryBubble obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.region)
      ..writeByte(1)
      ..write(obj.callbackIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryBubbleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
