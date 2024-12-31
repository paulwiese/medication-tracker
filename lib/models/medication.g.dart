// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicationAdapter extends TypeAdapter<Medication> {
  @override
  final int typeId = 0;

  @override
  Medication read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Medication(
      id: fields[0] as int,
      name: fields[1] as String,
      active: fields[2] as bool,
      cycle: fields[3] as int,
      last: fields[4] as DateTime,
      next: fields[5] as DateTime,
      stock: fields[6] as int,
      started: fields[7] as DateTime,
      total: fields[8] as int,
      category: fields[9] as String,
      prescription: fields[10] as bool,
      info: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Medication obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.active)
      ..writeByte(3)
      ..write(obj.cycle)
      ..writeByte(4)
      ..write(obj.last)
      ..writeByte(5)
      ..write(obj.next)
      ..writeByte(6)
      ..write(obj.stock)
      ..writeByte(7)
      ..write(obj.started)
      ..writeByte(8)
      ..write(obj.total)
      ..writeByte(9)
      ..write(obj.category)
      ..writeByte(10)
      ..write(obj.prescription)
      ..writeByte(11)
      ..write(obj.info);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
