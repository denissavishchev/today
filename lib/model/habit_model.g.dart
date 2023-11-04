// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitModelAdapter extends TypeAdapter<HabitModel> {
  @override
  final int typeId = 44;

  @override
  HabitModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitModel()
      ..name = fields[12] as String
      ..description = fields[13] as String
      ..totalTime = fields[14] as int
      ..days = fields[15] as int
      ..percent = fields[16] as double
      ..dateDay = fields[17] as int
      ..dateMonth = fields[18] as int
      ..dateYear = fields[19] as int
      ..skipped = fields[20] as int
      ..isTimer = fields[21] as bool
      ..isDone = fields[22] as bool;
  }

  @override
  void write(BinaryWriter writer, HabitModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(12)
      ..write(obj.name)
      ..writeByte(13)
      ..write(obj.description)
      ..writeByte(14)
      ..write(obj.totalTime)
      ..writeByte(15)
      ..write(obj.days)
      ..writeByte(16)
      ..write(obj.percent)
      ..writeByte(17)
      ..write(obj.dateDay)
      ..writeByte(18)
      ..write(obj.dateMonth)
      ..writeByte(19)
      ..write(obj.dateYear)
      ..writeByte(20)
      ..write(obj.skipped)
      ..writeByte(21)
      ..write(obj.isTimer)
      ..writeByte(22)
      ..write(obj.isDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
