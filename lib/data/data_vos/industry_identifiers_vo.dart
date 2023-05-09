import 'package:json_annotation/json_annotation.dart';

part 'industry_identifiers_vo.g.dart';

@JsonSerializable()
class IndustryIdentifiersVO{

  @JsonKey(name: "type")
  String? type;

  @JsonKey(name: "identifier")
  String? identifier;

  IndustryIdentifiersVO(this.type, this.identifier);


  factory IndustryIdentifiersVO.fromJson(Map<String, dynamic> json) => _$IndustryIdentifiersVOFromJson(json);

  Map<String, dynamic> toJson() => _$IndustryIdentifiersVOToJson(this);
}