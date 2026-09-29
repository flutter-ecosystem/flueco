// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileDBAdapter extends TypeAdapter<UserProfileDBModel> {
  @override
  final typeId = 1;

  @override
  UserProfileDBModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfileDBModel(
      id: (fields[0] as num).toInt(),
      uuid: fields[1] as String,
      name: fields[2] as String?,
      birthDate: fields[3] as DateTime?,
      height: (fields[4] as num?)?.toDouble(),
      weight: (fields[5] as num?)?.toDouble(),
      description: fields[6] as String?,
      gender: (fields[7] as num?)?.toInt(),
      sexuality: (fields[13] as num?)?.toInt(),
      createdAt: fields[14] as DateTime?,
      isActive: fields[11] as bool?,
      location: fields[12] as ({double latitude, double longitude})?,
      position: (fields[8] as num?)?.toInt(),
      relationshipStatus: (fields[9] as num?)?.toInt(),
      researchType: (fields[10] as num?)?.toInt(),
      updatedAt: fields[15] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfileDBModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.uuid)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.birthDate)
      ..writeByte(4)
      ..write(obj.height)
      ..writeByte(5)
      ..write(obj.weight)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.gender)
      ..writeByte(8)
      ..write(obj.position)
      ..writeByte(9)
      ..write(obj.relationshipStatus)
      ..writeByte(10)
      ..write(obj.researchType)
      ..writeByte(11)
      ..write(obj.isActive)
      ..writeByte(12)
      ..write(obj.location)
      ..writeByte(13)
      ..write(obj.sexuality)
      ..writeByte(14)
      ..write(obj.createdAt)
      ..writeByte(15)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
