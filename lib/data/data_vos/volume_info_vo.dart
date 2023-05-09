import 'package:google_play_book/data/data_vos/industry_identifiers_vo.dart';
import 'package:google_play_book/data/data_vos/panelization_summary_vo.dart';
import 'package:google_play_book/data/data_vos/reading_modes_vo.dart';
import 'package:json_annotation/json_annotation.dart';

import 'image_links_vo.dart';

part 'volume_info_vo.g.dart';

@JsonSerializable()
class VolumeInfoVO{

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "authors")
  List<String>? authors;

  @JsonKey(name: "publisher")
  String? publisher;

  @JsonKey(name: "publishedDate")
  String? publishedDate;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "industryIdentifiers")
  List<IndustryIdentifiersVO>? industryIdentifiers;

  @JsonKey(name: "readingModes")
  ReadingModesVO? readingModes;

  @JsonKey(name: "pageCount")
  int? pageCount;

  @JsonKey(name: "printType")
  String? printType;

  @JsonKey(name: "categories")
  List<String>? categories;

  @JsonKey(name: "maturityRating")
  String? maturityRating;

  @JsonKey(name: "allowAnonLogging")
  bool? allowAnonLogging;

  @JsonKey(name: "contentVersion")
  String? contentVersion;

  @JsonKey(name: "panelizationSummary")
  PanelizationSummaryVO? panelizationSummary;

  @JsonKey(name: "imageLinks")
  ImageLinksVO? imageLinks;

  @JsonKey(name: "language")
  String? language;

  @JsonKey(name: "previewLink")
  String? previewLink;

  @JsonKey(name: "infoLink")
  String? infoLink;

  @JsonKey(name: "canonicalVolumeLink")
  String? canonicalVolumeLink;

  VolumeInfoVO(this.title, this.authors, this.publishedDate, this.description,
      this.industryIdentifiers);


  factory VolumeInfoVO.fromJson(Map<String, dynamic> json) => _$VolumeInfoVOFromJson(json);

  Map<String, dynamic> toJson() => _$VolumeInfoVOToJson(this);
}