import 'package:google_play_book/data/data_vos/results_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_overview_response.g.dart';

@JsonSerializable()
class GetOverviewResponse{

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "copyright")
  String? copyright;

  @JsonKey(name: "num_results")
  int? numResults;

  @JsonKey(name: "results")
  ResultsVO? results;

  GetOverviewResponse(
      this.status, this.copyright, this.numResults, this.results);

  factory GetOverviewResponse.fromJson(Map<String, dynamic> json) => _$GetOverviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetOverviewResponseToJson(this);
}