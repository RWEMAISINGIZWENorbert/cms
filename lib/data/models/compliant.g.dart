// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compliant.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompliantAdapter extends TypeAdapter<Compliant> {
  @override
  final int typeId = 6;

  @override
  Compliant read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Compliant(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      status: fields[3] as CompliantStatus,
      categoryId: fields[4] as String,
      priority: fields[5] as CompliantPriority,
      location: fields[6] as String,
      submittedBy: fields[7] as String,
      telephoneNumber: fields[8] as String,
      assignedTo: fields[9] as String?,
      createdAt: fields[10] as DateTime,
      updatedAt: fields[11] as DateTime,
      attachments: (fields[12] as List).cast<String>(),
      syncStatus: fields[13] as SyncStatus,
      serverId: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Compliant obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.categoryId)
      ..writeByte(5)
      ..write(obj.priority)
      ..writeByte(6)
      ..write(obj.location)
      ..writeByte(7)
      ..write(obj.submittedBy)
      ..writeByte(8)
      ..write(obj.telephoneNumber)
      ..writeByte(9)
      ..write(obj.assignedTo)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.updatedAt)
      ..writeByte(12)
      ..write(obj.attachments)
      ..writeByte(13)
      ..write(obj.syncStatus)
      ..writeByte(14)
      ..write(obj.serverId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompliantAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CompliantStatusAdapter extends TypeAdapter<CompliantStatus> {
  @override
  final int typeId = 3;

  @override
  CompliantStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CompliantStatus.open;
      case 1:
        return CompliantStatus.inProgress;
      case 2:
        return CompliantStatus.resolved;
      case 3:
        return CompliantStatus.closed;
      case 4:
        return CompliantStatus.rejected;
      default:
        return CompliantStatus.open;
    }
  }

  @override
  void write(BinaryWriter writer, CompliantStatus obj) {
    switch (obj) {
      case CompliantStatus.open:
        writer.writeByte(0);
        break;
      case CompliantStatus.inProgress:
        writer.writeByte(1);
        break;
      case CompliantStatus.resolved:
        writer.writeByte(2);
        break;
      case CompliantStatus.closed:
        writer.writeByte(3);
        break;
      case CompliantStatus.rejected:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompliantStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CompliantPriorityAdapter extends TypeAdapter<CompliantPriority> {
  @override
  final int typeId = 4;

  @override
  CompliantPriority read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CompliantPriority.low;
      case 1:
        return CompliantPriority.normal;
      case 2:
        return CompliantPriority.high;
      case 3:
        return CompliantPriority.urgent;
      default:
        return CompliantPriority.low;
    }
  }

  @override
  void write(BinaryWriter writer, CompliantPriority obj) {
    switch (obj) {
      case CompliantPriority.low:
        writer.writeByte(0);
        break;
      case CompliantPriority.normal:
        writer.writeByte(1);
        break;
      case CompliantPriority.high:
        writer.writeByte(2);
        break;
      case CompliantPriority.urgent:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompliantPriorityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SyncStatusAdapter extends TypeAdapter<SyncStatus> {
  @override
  final int typeId = 5;

  @override
  SyncStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SyncStatus.pending;
      case 1:
        return SyncStatus.synced;
      case 2:
        return SyncStatus.failed;
      default:
        return SyncStatus.pending;
    }
  }

  @override
  void write(BinaryWriter writer, SyncStatus obj) {
    switch (obj) {
      case SyncStatus.pending:
        writer.writeByte(0);
        break;
      case SyncStatus.synced:
        writer.writeByte(1);
        break;
      case SyncStatus.failed:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SyncStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
