// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartAdapter extends TypeAdapter<Cart> {
  @override
  final int typeId = 0;

  @override
  Cart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cart(
      key: fields[0] as String?,
      id: fields[1] as String?,
      name: fields[2] as String?,
      category: fields[3] as String?,
      price: fields[4] as String?,
      size: fields[5] as String?,
      quantity: fields[6] as int?,
      imageUrl: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Cart obj) {
    writer
      ..writeByte(8)
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
      ..write(obj.size)
      ..writeByte(6)
      ..write(obj.quantity)
      ..writeByte(7)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
