import 'package:json_annotation/json_annotation.dart';

part 'isbns_vo.g.dart';

@JsonSerializable()
class IsbnsVO{

  @JsonKey(name: "isbn10")
  String? isbn10;

  @JsonKey(name: "isbn13")
  String? isbn13;

  IsbnsVO(this.isbn10, this.isbn13);

  factory IsbnsVO.fromJson(Map<String, dynamic> json) => _$IsbnsVOFromJson(json);

  Map<String, dynamic> toJson() => _$IsbnsVOToJson(this);
}