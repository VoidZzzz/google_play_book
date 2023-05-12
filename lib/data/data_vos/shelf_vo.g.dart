// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shelf_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShelfVOAdapter extends TypeAdapter<ShelfVO> {
  @override
  final int typeId = 3;

  @override
  ShelfVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShelfVO(
      fields[0] as String?,
      fields[1] as int?,
      (fields[2] as List?)?.cast<BooksVO>(),
      fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ShelfVO obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.shelfName)
      ..writeByte(1)
      ..write(obj.shelfId)
      ..writeByte(2)
      ..write(obj.books)
      ..writeByte(3)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShelfVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShelfVO _$ShelfVOFromJson(Map<String, dynamic> json) => ShelfVO(
      json['shelfName'] as String?,
      json['shelfId'] as int?,
      (json['books'] as List<dynamic>?)
          ?.map((e) => BooksVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['isSelected'] as bool,
    );

Map<String, dynamic> _$ShelfVOToJson(ShelfVO instance) => <String, dynamic>{
      'shelfName': instance.shelfName,
      'shelfId': instance.shelfId,
      'books': instance.books,
      'isSelected': instance.isSelected,
    };
