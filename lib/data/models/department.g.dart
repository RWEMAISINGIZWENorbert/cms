// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DepartmentAdapter extends TypeAdapter<Department> {
  @override
  final int typeId = 7;

  @override
  Department read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Department(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      categoryIds: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Department obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.categoryIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DepartmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
