// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyModelAdapter extends TypeAdapter<DailyModel> {
  @override
  final int typeId = 1;

  @override
  DailyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyModel()
      ..task = fields[5] as String
      ..description = fields[6] as String
      ..howMany = fields[7] as int
      ..done = fields[8] as int;
  }

  @override
  void write(BinaryWriter writer, DailyModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(5)
      ..write(obj.task)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.howMany)
      ..writeByte(8)
      ..write(obj.done);
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
