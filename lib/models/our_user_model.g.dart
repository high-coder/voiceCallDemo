// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'our_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OurUserDetailOriginal extends TypeAdapter<OurUser> {
  @override
  final int typeId = 123;

  @override
  OurUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OurUser(
      email: fields[1] as String?,
      name: fields[2] as String?,
      uid: fields[0] as String?,
    )..imgUrl = fields[3] as String?;
  }

  @override
  void write(BinaryWriter writer, OurUser obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.imgUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OurUserDetailOriginal &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
