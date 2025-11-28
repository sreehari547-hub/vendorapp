// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VendorModelAdapter extends TypeAdapter<VendorModel> {
  @override
  final int typeId = 0;

  @override
  VendorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VendorModel(
      firstName: fields[0] as String,
      lastName: fields[1] as String,
      email: fields[2] as String,
      mobile: fields[3] as String,
      password: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VendorModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.mobile)
      ..writeByte(4)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VendorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
