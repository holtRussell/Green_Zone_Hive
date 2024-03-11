// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MenuStateAdapter extends TypeAdapter<MenuState> {
  @override
  final int typeId = 4;

  @override
  MenuState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MenuState()..game = fields[0] as GameLogic;
  }

  @override
  void write(BinaryWriter writer, MenuState obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.game);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
