import 'package:json_annotation/json_annotation.dart';

import '../../data/data_vos/more_list_results_vo.dart';

part 'get_more_list_response.g.dart';

@JsonSerializable()
class GetMoreListResponse{

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "copyright")
  String? copyright;

  @JsonKey(name: "num_results")
  int? numResult;

  @JsonKey(name: "last_modified")
  String? lastModified;

  @JsonKey(name: "results")
  List<MoreListResultsVO>? results;

  GetMoreListResponse(this.status, this.copyright, this.numResult,
      this.lastModified, this.results);

  factory GetMoreListResponse.fromJson(Map<String, dynamic> json) => _$GetMoreListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetMoreListResponseToJson(this);
}