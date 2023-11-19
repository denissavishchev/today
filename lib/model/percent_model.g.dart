// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'percent_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PercentModelAdapter extends TypeAdapter<PercentModel> {
  @override
  final int typeId = 48;

  @override
  PercentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PercentModel()
      ..percent = fields[12] as int
      ..day = fields[13] as int
      ..month = fields[14] as int
      ..year = fields[15] as int
      ..dateTime = fields[16] as String;
  }

  @override
  void write(BinaryWriter writer, PercentModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(12)
      ..write(obj.percent)
      ..writeByte(13)
      ..write(obj.day)
      ..writeByte(14)
      ..write(obj.month)
      ..writeByte(15)
      ..write(obj.year)
      ..writeByte(16)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PercentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
