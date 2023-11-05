// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_storage_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitStorageModelAdapter extends TypeAdapter<HabitStorageModel> {
  @override
  final int typeId = 55;

  @override
  HabitStorageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitStorageModel()
      ..name = fields[24] as String
      ..description = fields[25] as String
      ..days = fields[26] as int
      ..skipped = fields[27] as int;
  }

  @override
  void write(BinaryWriter writer, HabitStorageModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(24)
      ..write(obj.name)
      ..writeByte(25)
      ..write(obj.description)
      ..writeByte(26)
      ..write(obj.days)
      ..writeByte(27)
      ..write(obj.skipped);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitStorageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
