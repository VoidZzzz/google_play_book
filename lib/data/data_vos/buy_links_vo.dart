import 'package:json_annotation/json_annotation.dart';

part 'buy_links_vo.g.dart';

@JsonSerializable()
class BuyLinksVO {

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "url")
  String? url;

  BuyLinksVO(this.name, this.url);

  factory BuyLinksVO.fromJson(Map<String, dynamic> json) => _$BuyLinksVOFromJson(json);

  Map<String, dynamic> toJson() => _$BuyLinksVOToJson(this);
}