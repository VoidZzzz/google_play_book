import 'package:json_annotation/json_annotation.dart';
import '../../data/data_vos/items_vo.dart';

part 'get_google_search_response.g.dart';

@JsonSerializable()
class GetGoogleSearchResponse{

  @JsonKey(name: "kind")
  String? kind;

  @JsonKey(name: "totalItems")
  int? totalItems;

  @JsonKey(name: "items")
  List<ItemsVO>? items;

  GetGoogleSearchResponse(this.kind, this.totalItems, this.items);


  factory GetGoogleSearchResponse.fromJson(Map<String, dynamic> json) => _$GetGoogleSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetGoogleSearchResponseToJson(this);
}