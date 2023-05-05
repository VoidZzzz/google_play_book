// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lists_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListsVO _$ListsVOFromJson(Map<String, dynamic> json) => ListsVO(
      json['list_id'] as int?,
      json['list_name'] as String?,
      json['list_name_encoded'] as String?,
      json['display_name'] as String?,
      json['updated'] as String?,
      json['list_image'] as String?,
      json['list_image_width'] as String?,
      json['list_image_height'] as String?,
      (json['books'] as List<dynamic>?)
          ?.map((e) => BooksVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListsVOToJson(ListsVO instance) => <String, dynamic>{
      'list_id': instance.listId,
      'list_name': instance.listName,
      'list_name_encoded': instance.listNameEncoded,
      'display_name': instance.displayName,
      'updated': instance.updated,
      'list_image': instance.listImage,
      'list_image_width': instance.listImageWidth,
      'list_image_height': instance.listImageHeight,
      'books': instance.books,
    };
