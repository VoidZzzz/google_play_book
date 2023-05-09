// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_info_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VolumeInfoVO _$VolumeInfoVOFromJson(Map<String, dynamic> json) => VolumeInfoVO(
      json['title'] as String?,
      (json['authors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['publishedDate'] as String?,
      json['description'] as String?,
      (json['industryIdentifiers'] as List<dynamic>?)
          ?.map(
              (e) => IndustryIdentifiersVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..publisher = json['publisher'] as String?
      ..readingModes = json['readingModes'] == null
          ? null
          : ReadingModesVO.fromJson(
              json['readingModes'] as Map<String, dynamic>)
      ..pageCount = json['pageCount'] as int?
      ..printType = json['printType'] as String?
      ..categories = (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..maturityRating = json['maturityRating'] as String?
      ..allowAnonLogging = json['allowAnonLogging'] as bool?
      ..contentVersion = json['contentVersion'] as String?
      ..panelizationSummary = json['panelizationSummary'] == null
          ? null
          : PanelizationSummaryVO.fromJson(
              json['panelizationSummary'] as Map<String, dynamic>)
      ..imageLinks = json['imageLinks'] == null
          ? null
          : ImageLinksVO.fromJson(json['imageLinks'] as Map<String, dynamic>)
      ..language = json['language'] as String?
      ..previewLink = json['previewLink'] as String?
      ..infoLink = json['infoLink'] as String?
      ..canonicalVolumeLink = json['canonicalVolumeLink'] as String?;

Map<String, dynamic> _$VolumeInfoVOToJson(VolumeInfoVO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'authors': instance.authors,
      'publisher': instance.publisher,
      'publishedDate': instance.publishedDate,
      'description': instance.description,
      'industryIdentifiers': instance.industryIdentifiers,
      'readingModes': instance.readingModes,
      'pageCount': instance.pageCount,
      'printType': instance.printType,
      'categories': instance.categories,
      'maturityRating': instance.maturityRating,
      'allowAnonLogging': instance.allowAnonLogging,
      'contentVersion': instance.contentVersion,
      'panelizationSummary': instance.panelizationSummary,
      'imageLinks': instance.imageLinks,
      'language': instance.language,
      'previewLink': instance.previewLink,
      'infoLink': instance.infoLink,
      'canonicalVolumeLink': instance.canonicalVolumeLink,
    };
