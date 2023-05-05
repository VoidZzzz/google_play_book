// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_more_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMoreListResponse _$GetMoreListResponseFromJson(Map<String, dynamic> json) =>
    GetMoreListResponse(
      json['status'] as String?,
      json['copyright'] as String?,
      json['num_results'] as int?,
      json['last_modified'] as String?,
      (json['results'] as List<dynamic>?)
          ?.map((e) => MoreListResultsVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMoreListResponseToJson(
        GetMoreListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'copyright': instance.copyright,
      'num_results': instance.numResult,
      'last_modified': instance.lastModified,
      'results': instance.results,
    };
