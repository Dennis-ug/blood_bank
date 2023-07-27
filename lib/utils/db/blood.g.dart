// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BloodInDbAdapter extends TypeAdapter<BloodInDb> {
  @override
  final int typeId = 0;

  @override
  BloodInDb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BloodInDb()
      ..name = fields[0] as String
      ..batchNo = fields[1] as String
      ..station = fields[2] as String
      ..bloodType = fields[3] as String
      ..dOfCollection = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, BloodInDb obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.batchNo)
      ..writeByte(2)
      ..write(obj.station)
      ..writeByte(3)
      ..write(obj.bloodType)
      ..writeByte(4)
      ..write(obj.dOfCollection);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodInDbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BloodOutDbAdapter extends TypeAdapter<BloodOutDb> {
  @override
  final int typeId = 1;

  @override
  BloodOutDb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BloodOutDb()
      ..batchNo = fields[0] as String
      ..hospital = fields[1] as String
      ..dOfDisbatch = fields[2] as String
      ..bloodType = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, BloodOutDb obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.batchNo)
      ..writeByte(1)
      ..write(obj.hospital)
      ..writeByte(2)
      ..write(obj.dOfDisbatch)
      ..writeByte(3)
      ..write(obj.bloodType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodOutDbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StationsAdapter extends TypeAdapter<Stations> {
  @override
  final int typeId = 2;

  @override
  Stations read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Stations()
      ..name = fields[0] as String
      ..dOfDisbatch = fields[1] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Stations obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.dOfDisbatch);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StationsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
