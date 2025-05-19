// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationAdapter extends TypeAdapter<Notification> {
  @override
  final int typeId = 2;

  @override
  Notification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Notification(
      id: fields[0] as String,
      type: fields[1] as NotificationType,
      message: fields[2] as String,
      createdAt: fields[3] as DateTime,
      read: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Notification obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.message)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.read);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NotificationTypeAdapter extends TypeAdapter<NotificationType> {
  @override
  final int typeId = 1;

  @override
  NotificationType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NotificationType.statusUpdate;
      case 1:
        return NotificationType.assignment;
      case 2:
        return NotificationType.newComplaint;
      case 3:
        return NotificationType.comment;
      case 4:
        return NotificationType.reminder;
      default:
        return NotificationType.statusUpdate;
    }
  }

  @override
  void write(BinaryWriter writer, NotificationType obj) {
    switch (obj) {
      case NotificationType.statusUpdate:
        writer.writeByte(0);
        break;
      case NotificationType.assignment:
        writer.writeByte(1);
        break;
      case NotificationType.newComplaint:
        writer.writeByte(2);
        break;
      case NotificationType.comment:
        writer.writeByte(3);
        break;
      case NotificationType.reminder:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
