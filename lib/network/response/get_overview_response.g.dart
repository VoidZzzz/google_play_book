// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_overview_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOverviewResponse _$GetOverviewResponseFromJson(Map<String, dynamic> json) =>
    GetOverviewResponse(
      json['status'] as String?,
      json['copyright'] as String?,
      json['num_results'] as int?,
      json['results'] == null
          ? null
          : ResultsVO.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetOverviewResponseToJson(
        GetOverviewResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'copyright': instance.copyright,
      'num_results': instance.numResults,
      'results': instance.results,
    };
