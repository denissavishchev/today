// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyModelAdapter extends TypeAdapter<DailyModel> {
  @override
  final int typeId = 65;

  @override
  DailyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyModel()
      ..task = fields[11] as String
      ..description = fields[22] as String
      ..howMany = fields[33] as int
      ..done = fields[44] as int
      ..day = fields[55] as int
      ..dateTime = fields[66] as String;
  }

  @override
  void write(BinaryWriter writer, DailyModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(11)
      ..write(obj.task)
      ..writeByte(22)
      ..write(obj.description)
      ..writeByte(33)
      ..write(obj.howMany)
      ..writeByte(44)
      ..write(obj.done)
      ..writeByte(55)
      ..write(obj.day)
      ..writeByte(66)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
