// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WaterSettingsModelAdapter extends TypeAdapter<WaterSettingsModel> {
  @override
  final int typeId = 67;

  @override
  WaterSettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WaterSettingsModel()
      ..target = fields[0] as int
      ..wakeUpTime = fields[1] as String
      ..bedTime = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, WaterSettingsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.target)
      ..writeByte(1)
      ..write(obj.wakeUpTime)
      ..writeByte(2)
      ..write(obj.bedTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WaterSettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
