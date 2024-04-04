// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavAdapter extends TypeAdapter<Fav> {
  @override
  final int typeId = 1;

  @override
  Fav read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Fav(
      key: fields[0] as String?,
      id: fields[1] as String?,
      name: fields[2] as String?,
      category: fields[3] as String?,
      price: fields[4] as String?,
      imageUrl: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Fav obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
