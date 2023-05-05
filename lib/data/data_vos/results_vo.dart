import 'package:json_annotation/json_annotation.dart';
import 'lists_vo.dart';

part 'results_vo.g.dart';

@JsonSerializable()
class ResultsVO{

  @JsonKey(name: "bestsellers_date")
  String? bestsellersDate;

  @JsonKey(name: "published_date")
  String? publishedDate;

  @JsonKey(name: "published_date_description")
  String? publishedDateDescription;

  @JsonKey(name: "previous_published_date")
  String? previousPublishedDate;

  @JsonKey(name: "next_published_date")
  String? nextPublishedDate;

  @JsonKey(name: "lists")
  List<ListsVO>? lists;

  ResultsVO(
      this.bestsellersDate,
      this.publishedDate,
      this.publishedDateDescription,
      this.previousPublishedDate,
      this.nextPublishedDate,
      this.lists);

  factory ResultsVO.fromJson(Map<String, dynamic> json) => _$ResultsVOFromJson(json);

  Map<String, dynamic> toJson() => _$ResultsVOToJson(this);
}