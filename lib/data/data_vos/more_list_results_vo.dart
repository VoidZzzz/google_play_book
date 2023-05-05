import 'package:google_play_book/data/data_vos/reviews_vo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'books_vo.dart';
import 'isbns_vo.dart';

part 'more_list_results_vo.g.dart';

@JsonSerializable()
class MoreListResultsVO {

  @JsonKey(name: "list_name")
  String? listName;

  @JsonKey(name: "display_name")
  String? displayName;

  @JsonKey(name: "bestsellers_date")
  String? bestSellersDate;

  @JsonKey(name: "published_date")
  String? publishedDate;

  @JsonKey(name: "rank")
  int? rank;

  @JsonKey(name: "rank_last_week")
  int? rankLastWeek;

  @JsonKey(name: "weeks_on_list")
  int? weeksOnList;

  @JsonKey(name: "asterisk")
  int? asterIsk;

  @JsonKey(name: "dagger")
  int? dagger;

  @JsonKey(name: "amazon_product_url")
  String? amazonProductUrl;

  @JsonKey(name: "isbns")
  List<IsbnsVO>? isbns;

  @JsonKey(name: "book_details")
  List<BooksVO>? bookDetails;

  @JsonKey(name: "reviews")
  List<ReviewsVO>? reviews;

  MoreListResultsVO(
      this.listName,
      this.displayName,
      this.bestSellersDate,
      this.publishedDate,
      this.rank,
      this.rankLastWeek,
      this.weeksOnList,
      this.asterIsk,
      this.dagger,
      this.amazonProductUrl,
      this.isbns,
      this.bookDetails,
      this.reviews);

  factory MoreListResultsVO.fromJson(Map<String, dynamic> json) => _$MoreListResultsVOFromJson(json);

  Map<String, dynamic> toJson() => _$MoreListResultsVOToJson(this);
}