// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_google_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGoogleSearchResponse _$GetGoogleSearchResponseFromJson(
        Map<String, dynamic> json) =>
    GetGoogleSearchResponse(
      json['kind'] as String?,
      json['totalItems'] as int?,
      (json['items'] as List<dynamic>?)
          ?.map((e) => ItemsVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetGoogleSearchResponseToJson(
        GetGoogleSearchResponse instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'totalItems': instance.totalItems,
      'items': instance.items,
    };
