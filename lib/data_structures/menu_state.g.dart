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
    return MenuState();
  }

  @override
  void write(BinaryWriter writer, MenuState obj) {
    writer.writeByte(0);
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
